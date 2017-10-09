import xml.etree.ElementTree as ET
import glob
import sys
import codecs

target_dir = sys.argv[1]
f = codecs.open(target_dir + "text", "w", "utf-8")

for file in glob.glob(target_dir + "*.xml"):
	root = ET.parse(file).getroot()
	cleaned_sentence = root.find("cleaned_sentence")
	print(cleaned_sentence.text.encode("utf-8"))
	fileid = file.split("/")[-1].split(".xml")[0]
	print(fileid)
	f.write(fileid + "\t" + cleaned_sentence.text.replace("\n","") + "\n")
f.close()
