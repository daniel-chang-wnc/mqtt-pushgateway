Feature: MQTT stuff.

  Scenario: Float values

     when Topic sensor/bathroom/temperature receives message with payload "15.2"
     then Metric 'temperature{sensor_name="bathroom",mqtt_topic="sensor/bathroom/temperature"}' exists
      and its value is equal to 15.2
      and Metric 'mqtt_data_age{sensor_name="bathroom",mqtt_topic="sensor/bathroom/temperature",metric="temperature"}' exists
      and its value is less than 0.5

  Scenario: String values

     when Topic sensor/bathroom/window receives message with payload "OPEN"
     then Metric 'window{sensor_name="bathroom",mqtt_topic="sensor/bathroom/window",window="OPEN"}' exists
      and its value is equal to 1.0
      and Metric 'mqtt_data_age{sensor_name="bathroom",mqtt_topic="sensor/bathroom/window",metric="window"}' exists
      and its value is less than 0.5
     when Topic sensor/bathroom/window receives message with payload "CLOSED"
     then Metric 'window{sensor_name="bathroom",mqtt_topic="sensor/bathroom/window",window="OPEN"}' exists
      and its value is equal to 0.0
      and Metric 'window{sensor_name="bathroom",mqtt_topic="sensor/bathroom/window",window="CLOSED"}' exists
      and its value is equal to 1.0
      and Metric 'mqtt_data_age{sensor_name="bathroom",mqtt_topic="sensor/bathroom/window",metric="window"}' exists
      and its value is less than 0.5

  Scenario: JSON values

     when Topic zigbee2mqtt/sensor/lounge/xiaomi/WSDCGQ01LM receives message of
        """
        {"temperature":29.02,"linkquality":34,"humidity":55.58,"battery":100,"voltage":3005}
        """
     then Metric 'temperature{mqtt_topic="zigbee2mqtt/sensor/lounge/xiaomi/WSDCGQ01LM/temperature"}' exists
      and its value is equal to 29.02
     then Metric 'linkquality{mqtt_topic="zigbee2mqtt/sensor/lounge/xiaomi/WSDCGQ01LM/linkquality"}' exists
      and its value is equal to 34.0
     then Metric 'humidity{mqtt_topic="zigbee2mqtt/sensor/lounge/xiaomi/WSDCGQ01LM/humidity"}' exists
      and its value is equal to 55.58
     then Metric 'battery{mqtt_topic="zigbee2mqtt/sensor/lounge/xiaomi/WSDCGQ01LM/battery"}' exists
      and its value is equal to 100.0
     then Metric 'voltage{mqtt_topic="zigbee2mqtt/sensor/lounge/xiaomi/WSDCGQ01LM/voltage"}' exists
      and its value is equal to 3005.0