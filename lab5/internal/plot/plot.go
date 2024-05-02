package plot

import (
	"image/color"
	"log"

	"github.com/zzucch/itmo-is-os-2024-4-sem/internal/parse"
	"gonum.org/v1/plot"
	"gonum.org/v1/plot/plotter"
	"gonum.org/v1/plot/vg"
)

func PlotMemData(data []parse.MemData) {
	p := plot.New()

	p.Title.Text = "MiB Mem Over Time"
	p.X.Label.Text = "Time (seconds)"
	p.Y.Label.Text = "MiB"

	ptsTotal := make(plotter.XYs, len(data))
	ptsFree := make(plotter.XYs, len(data))
	ptsUsed := make(plotter.XYs, len(data))

	refTime := float64(data[0].Time)

	for i, d := range data {
		ptsTotal[i].X = float64(d.Time) - refTime
		ptsTotal[i].Y = d.Total

		ptsFree[i].X = float64(d.Time) - refTime
		ptsFree[i].Y = d.Free

		ptsUsed[i].X = float64(d.Time) - refTime
		ptsUsed[i].Y = d.Used
	}

	w := vg.Points(1)
	totalLine, err := plotter.NewLine(ptsTotal)
	if err != nil {
		log.Fatal(err)
	}
	totalLine.Width = w
	totalLine.Color = color.RGBA{B: 255, A: 255}

	freeLine, err := plotter.NewLine(ptsFree)
	if err != nil {
		log.Fatal(err)
	}
	freeLine.Width = w
	freeLine.Color = color.RGBA{G: 255, A: 255}

	usedLine, err := plotter.NewLine(ptsUsed)
	if err != nil {
		log.Fatal(err)
	}
	usedLine.Width = w
	usedLine.Color = color.RGBA{R: 255, A: 255}

	p.Add(totalLine, freeLine, usedLine)
	p.Legend.Add("Total", totalLine)
	p.Legend.Add("Free", freeLine)
	p.Legend.Add("Used", usedLine)

	p.X.Min = 0
	p.X.Max = float64(data[len(data)-1].Time) - refTime
	p.Y.Min = 0
	p.Y.Max = 16000

	if err := p.Save(5*vg.Inch, 3*vg.Inch, "plot1-1.png"); err != nil {
		log.Fatal(err)
	}
}
