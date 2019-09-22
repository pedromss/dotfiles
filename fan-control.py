# https://www.hackster.io/104931/smart-raspberry-pi-cpu-fan-2fa422
import RPi.GPIO as IO
from gpiozero import CPUTemperature
import time

minspin = 10


IO.setwarnings(False)
IO.setmode(IO.BCM)
IO.setup(14,IO.OUT)
fan = IO.PWM(14, 100)

cpu = CPUTemperature()

fan.start(0)

oldtemp = cpu.temperature

while True:
    temp = cpu.temperature
    if abs(temp - oldtemp) < 1.5:
        time.sleep(1)
        print(str(temp)+"  skipped")
        continue
    oldtemp = temp
    if temp > 50:
        speed = ((temp - 45)*4)+minspin
        if speed > 100:
            speed = 100
        fan.ChangeDutyCycle(speed)
        print(str(temp)+"  "+str(speed)+"  fan on")
    else:
        fan.ChangeDutyCycle(0)
        print(str(temp)+"  fan off")
    time.sleep(1)
fan.stop()
IO.cleanup()
print("done")
