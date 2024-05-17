package main

import (
	"bufio"
	"os"
	"strconv"

	"github.com/charmbracelet/log"
	"gonum.org/v1/plot"
	"gonum.org/v1/plot/plotter"
	"gonum.org/v1/plot/vg"
)

func main() {
	if len(os.Args) < 3 {
		log.Fatal("provide a data filename and an output filename as arguments")
	}

	fileName := os.Args[1]
	outputFileName := os.Args[2]

	file, err := os.Open(fileName)
	if err != nil {
		log.Fatal("failed to open file")
	}
	defer file.Close()

	var data []float64

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		value, err := strconv.ParseFloat(line, 64)
		if err != nil {
			log.Printf("Error parsing value on line %q: %v\n", line, err)
			continue
		}
		data = append(data, value)
	}

	if err := scanner.Err(); err != nil {
		log.Fatal("failed to scan file:", "err", err)
	}

	plotData(data, outputFileName)
}

func plotData(data []float64, outputFileName string) {
	p := plot.New()

	p.Title.Text = "Time vs index"
	p.X.Label.Text = "Index"
	p.Y.Label.Text = "Time"

	xy := make(plotter.XYs, len(data))
	for i, v := range data {
		xy[i] = plotter.XY{X: float64(i), Y: v}
	}

	s, err := plotter.NewLine(xy)
	if err != nil {
		log.Fatal("failed to create line from data", "err", err)
	}

	p.Add(s)
	p.Legend.Add("Time", s)

	if err := p.Save(5*vg.Inch, 3*vg.Inch, outputFileName); err != nil {
		log.Fatal("failed to save plot", "err", err)
	}
}
