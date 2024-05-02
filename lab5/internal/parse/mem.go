package parse

import (
	"strconv"
	"strings"
)

type MemData struct {
	Time  int64
	Total float64
	Free  float64
	Used  float64
}

func ParseMemLine(line string) MemData {
	fields := strings.Fields(strings.Split(line, ":")[1])

	total, _ := strconv.ParseFloat(fields[0], 64)
	free, _ := strconv.ParseFloat(fields[2], 64)
	used, _ := strconv.ParseFloat(fields[4], 64)

	return MemData{
		Total: total,
		Free:  free,
		Used:  used,
	}
}
