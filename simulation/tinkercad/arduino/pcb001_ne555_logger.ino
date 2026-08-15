const int VOUT_PIN = A0;
const int VCAP_PIN = A1;
const int VCC_PIN  = A2;

const float ADC_REF = 5.0;
const float ADC_MAX = 1023.0;

const unsigned long SETTLE_TIME_MS  = 2000;
const unsigned long CAPTURE_TIME_MS = 8000;
const unsigned long SAMPLE_TIME_MS  = 10;

const float STATE_THRESHOLD = 2.5;

unsigned long captureStart;
unsigned long nextSample;

// Edge/cycle tracking
bool previousState;
bool stateInitialised = false;

unsigned long cycleRiseTime = 0;
unsigned long fallTime = 0;
bool haveRise = false;
bool haveFall = false;

double sumHigh = 0.0;
double sumLow = 0.0;
double sumPeriod = 0.0;

unsigned int completeCycles = 0;

// Voltage statistics
float vcapMin = 99.0;
float vcapMax = -99.0;

float voutMin = 99.0;
float voutMax = -99.0;

double vccSum = 0.0;
unsigned long sampleCount = 0;

bool finished = false;

void setup()
{
  Serial.begin(115200);

  Serial.println();
  Serial.println("PCB-001 NE555 TinkerCAD Verification");
  Serial.println("-----------------------------------");
  Serial.println("Settling circuit for 2 seconds...");

  delay(SETTLE_TIME_MS);

  captureStart = millis();
  nextSample = captureStart;

  Serial.println("Beginning 8 second measurement window.");
  Serial.println();

  Serial.println("EDGE LOG");
  Serial.println("------------------------------------------");
  Serial.println("Time(ms)\tEdge\tVCAP(V)\tVOUT(V)");
  Serial.println("------------------------------------------");
}

void loop()
{
  if (finished)
    return;

  unsigned long now = millis();
  unsigned long elapsed = now - captureStart;

  if (elapsed >= CAPTURE_TIME_MS)
  {
    printSummary();
    finished = true;
    return;
  }

  if (now >= nextSample)
  {
    int rawVout = analogRead(VOUT_PIN);
    int rawVcap = analogRead(VCAP_PIN);
    int rawVcc  = analogRead(VCC_PIN);

    float vout = rawVout * ADC_REF / ADC_MAX;
    float vcap = rawVcap * ADC_REF / ADC_MAX;
    float vcc  = rawVcc  * ADC_REF / ADC_MAX;

    bool currentState = (vout > STATE_THRESHOLD);

    // Voltage statistics
    if (vcap < vcapMin) vcapMin = vcap;
    if (vcap > vcapMax) vcapMax = vcap;

    if (vout < voutMin) voutMin = vout;
    if (vout > voutMax) voutMax = vout;

    vccSum += vcc;
    sampleCount++;

    // Initialise state
    if (!stateInitialised)
    {
      previousState = currentState;
      stateInitialised = true;
    }

    // Detect transition
    else if (currentState != previousState)
    {
      // LOW -> HIGH: rising edge
      if (currentState)
      {
        Serial.print(elapsed);
        Serial.print("\t\tRISE\t");
        Serial.print(vcap, 4);
        Serial.print("\t");
        Serial.println(vout, 4);

        // Complete a full RISE -> FALL -> RISE cycle
        if (haveRise && haveFall)
        {
          unsigned long tHigh = fallTime - cycleRiseTime;
          unsigned long tLow = elapsed - fallTime;
          unsigned long period = elapsed - cycleRiseTime;

          sumHigh += tHigh;
          sumLow += tLow;
          sumPeriod += period;

          completeCycles++;
        }

        cycleRiseTime = elapsed;
        haveRise = true;
        haveFall = false;
      }

      // HIGH -> LOW: falling edge
      else
      {
        Serial.print(elapsed);
        Serial.print("\t\tFALL\t");
        Serial.print(vcap, 4);
        Serial.print("\t");
        Serial.println(vout, 4);

        if (haveRise)
        {
          fallTime = elapsed;
          haveFall = true;
        }
      }

      previousState = currentState;
    }

    nextSample += SAMPLE_TIME_MS;
  }
}

void printSummary()
{
  Serial.println();
  Serial.println("============================================================");
  Serial.println("PCB-001 TINKERCAD MEASUREMENT SUMMARY");
  Serial.println("============================================================");

  Serial.print("Complete cycles analysed : ");
  Serial.println(completeCycles);

  if (completeCycles > 0)
  {
    double avgHighMs = sumHigh / completeCycles;
    double avgLowMs = sumLow / completeCycles;
    double avgPeriodMs = sumPeriod / completeCycles;

    double frequencyHz = 1000.0 / avgPeriodMs;
    double dutyPercent = 100.0 * avgHighMs / avgPeriodMs;

    Serial.println();
    Serial.println("TIMING");
    Serial.println("--------------------------------------------");

    Serial.print("Average tHIGH (ms)      : ");
    Serial.println(avgHighMs, 3);

    Serial.print("Average tLOW (ms)       : ");
    Serial.println(avgLowMs, 3);

    Serial.print("Average period (ms)     : ");
    Serial.println(avgPeriodMs, 3);

    Serial.print("Frequency (Hz)          : ");
    Serial.println(frequencyHz, 4);

    Serial.print("Duty cycle (%)          : ");
    Serial.println(dutyPercent, 3);
  }

  Serial.println();
  Serial.println("VOLTAGES");
  Serial.println("--------------------------------------------");

  Serial.print("VCAP minimum (V)        : ");
  Serial.println(vcapMin, 4);

  Serial.print("VCAP maximum (V)        : ");
  Serial.println(vcapMax, 4);

  Serial.print("VOUT minimum (V)        : ");
  Serial.println(voutMin, 4);

  Serial.print("VOUT maximum (V)        : ");
  Serial.println(voutMax, 4);

  if (sampleCount > 0)
  {
    Serial.print("Average VCC (V)         : ");
    Serial.println(vccSum / sampleCount, 4);
  }

  Serial.println();
  Serial.println("Capture duration         : 8000 ms");
  Serial.println("Sample interval          : 10 ms");
  Serial.println("============================================================");
  Serial.println("CAPTURE COMPLETE");
}
