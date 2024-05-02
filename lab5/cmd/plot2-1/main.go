package main

import (
	"bufio"
	"os"
	"regexp"
	"strings"
	"time"

	"github.com/charmbracelet/log"
	"github.com/zzucch/itmo-is-os-2024-4-sem/internal/parse"
	"github.com/zzucch/itmo-is-os-2024-4-sem/internal/plot"
)

func main() {
	file, err := os.Open("monitor2-1.log")
	if err != nil {
		log.Fatal("failed to open file", "err", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	var data []parse.MemData
	var currentTime string

	weekdayRegex := regexp.MustCompile(`(Mon|Tue|Wed|Thu|Fri|Sat|Sun) `)

	for scanner.Scan() {
		line := scanner.Text()

		if weekdayRegex.MatchString(line) {
			currentTime = line
		} else if strings.HasPrefix(line, "MiB Mem") {
			mem := parse.ParseMemLine(line)

			timestamp, _ := time.Parse("Mon May _2 3:04:05 PM MSK 2006", currentTime)
			mem.Time = timestamp.Unix()

			data = append(data, mem)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal("failed to scan", "err", err)
	}

	plot.PlotMemData(data, "plot2-1")
}
