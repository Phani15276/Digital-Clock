# Digital-clock
A hardware design project using verilog implementing a digital clock with support for 12h/24h format with set time and reset time features, a configurable alarm system, and a stopwatch. The design is modular (separate files for clock, alarm, stopwatch), and includes a testbench (testbench.v) for simulation and verification.


## 🛠 Features
### 1. Clock Core (`clock.v`)
- Supports **12-hour and 24-hour modes**
- Correct rollover of seconds, minutes, and hours
- [h1][h0]:[m1][m0]:[s1][s0] represents HH:MM:SS format.
- am, pm outputs in 12-hour mode (both 0 in 24-hour mode)
### 2. Set and Reset
- User has access to set, reset inputs along with a,b,c,d,e,f inputs.
- User can reset the time to 00:00:00 by giving reset input to 1. It stays at 00:00:00 until reset is turned off. A short pulse (0->1->0) also works.
- User can set the time by giving input to [a][b]:[c][d]:[e][f] (HH:MM:SS format) to adjust the time. It stays at the set time until set is turned off. A short pulse (0->1->0) also works.
### 3. Alarm (`alarm.v`)
- User-configurable alarm time [ain1][ain2]:[ain3][ain4] in HH:MM format (24-hour).
- **Enable** and **reset** controls
- Alarm signal output when time matches, stays on for the alarm timer (a_timer = 60 sec by default).

### 4. Stopwatch (`stopwatch.v`)
- **Start, pause, restart** functionality
- 32-bit counter for elapsed time tracking

### 5. Top Module (`main.v`)
- Module name `de`
- Integrates **clock**, **alarm** and **stopwatch**
- Provides consolidated inputs/outputs

### 6. Testbench (`testbench.v`)
- Drives clock, alarm, and stopwatch for verification
- Simulates in both **12-hour and 24-hour** formats
- Tests set and reset
- Tests alarm trigger
- Tests stopwatch start, pause, and restart


## 🔌 Interface Signals
### Top Module Inputs:
- clk: Main clock input (1 Hz)
- r: Reset time to 00:00:00
- s: Set time
- hour_24: 0 = 12-hour mode, 1 = 24-hour mode
- a,b,c,d,e,f: Time setting inputs (BCD digits)
- a_set: Alarm mode
- a_enable: Alarm on/off control
- a_reset: Stop the alarm
- ain1,ain2,ain3,ain4: Alarm time inputs (BCD digits)
- start, pause, restart: Stopwatch controls
### Top Module Outputs:
- h1, h0: Hour digits
- m1, m0: Minute digits
- s1, s0: Second digits
- am, pm: AM/PM indicator (12-hour mode only)
- a_out: Alarm active signal
- count: Stopwatch count
- stopwatch_active: Stopwatch running indicator

## ⚙️ Operation Instructions
### Time Setting:
- Apply desired time to input digits [a][b]:[c][d]:[e][f]
- Pulse s (0→1→0) to confirm
### Reset Operation:
- Pulse r (0→1→0) to reset time to 00:00:00
### Alarm Setting:
- Input alarm time via ain1, ain2, ain3, ain4
- Set a_set = 1 and a_enable = 1
- Set a_reset = 1 to stop the alarm
### Stopwatch Operation:
- start = 1 to start, pause = 1 to pause, restart = 1 to clear

## 🔄 Simulation
- Using Icarus Verilog:
  - iverilog -o sim testbench.v main.v clock.v alarm.v stopwatch.v
  - vvp sim

## 📝 Notes
- All time values are represented in BCD format
- The design uses positive-edge triggered flip-flops throughout
- Input debouncing should be handled externally if needed
- The #1 delay in testbench represents 1ms simulation time
