package main

import (
	"bufio"
	"log"
	"os"
	"strings"
	"time"

	"github.com/zzucch/itmo-is-os-2024-4-sem/internal/parse"
	"github.com/zzucch/itmo-is-os-2024-4-sem/internal/plot"
)

func main() {
	file, err := os.Open("monitor1-1.log")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var data []parse.MemData
	var currentTime string

	for scanner.Scan() {
		line := scanner.Text()

		if strings.HasPrefix(line, "Thu") {
			currentTime = line
		} else if strings.HasPrefix(line, "MiB Mem") {
			mem := parse.ParseMemLine(line)

			timestamp, _ := time.Parse("Mon May _2 3:04:05 PM MSK 2006", currentTime)
			mem.Time = timestamp.Unix()

			data = append(data, mem)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	plot.PlotMemData(data)
}
