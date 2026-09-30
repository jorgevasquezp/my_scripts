import json
import struct

with open("/yorchnet-guindos/ai/models/Lora/drawix8.safetensors", "rb") as f:
    length_of_header = struct.unpack('<Q', f.read(8))[0]
    header_data = f.read(length_of_header)
    header = json.loads(header_data)

print(header)  # should be a dict that contains what you need
