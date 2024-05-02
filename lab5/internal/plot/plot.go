package plot

import (
	"image/color"

	"github.com/charmbracelet/log"
	"github.com/zzucch/itmo-is-os-2024-4-sem/internal/parse"
	"gonum.org/v1/plot"
	"gonum.org/v1/plot/plotter"
	"gonum.org/v1/plot/vg"
)

func PlotMemData(data []parse.MemData, filename string) {
	plot := plot.New()

	plot.Title.Text = "MiB Mem Over Time"
	plot.X.Label.Text = "Time (seconds)"
	plot.Y.Label.Text = "MiB"

	ptsTotal := make(plotter.XYs, len(data))
	ptsFree := make(plotter.XYs, len(data))
	ptsUsed := make(plotter.XYs, len(data))

	startTime := float64(data[0].Time)

	for i, d := range data {
		ptsTotal[i].X = float64(d.Time) - startTime
		ptsTotal[i].Y = d.Total

		ptsFree[i].X = float64(d.Time) - startTime
		ptsFree[i].Y = d.Free

		ptsUsed[i].X = float64(d.Time) - startTime
		ptsUsed[i].Y = d.Used
	}

	width := vg.Points(1)
	totalLine, err := plotter.NewLine(ptsTotal)
	if err != nil {
		log.Fatal("failed to get total line", "err", err)
	}
	totalLine.Width = width
	totalLine.Color = color.RGBA{B: 255, A: 255}

	freeLine, err := plotter.NewLine(ptsFree)
	if err != nil {
		log.Fatal("failed to get free line", "err", err)
	}
	freeLine.Width = width
	freeLine.Color = color.RGBA{G: 255, A: 255}

	usedLine, err := plotter.NewLine(ptsUsed)
	if err != nil {
		log.Fatal("failed to get used line", "err", err)
	}
	usedLine.Width = width
	usedLine.Color = color.RGBA{R: 255, A: 255}

	plot.Add(totalLine, freeLine, usedLine)

	plot.Legend.Add("Total", totalLine)
	plot.Legend.Add("Free", freeLine)
	plot.Legend.Add("Used", usedLine)

	plot.X.Min = 0
	plot.X.Max = float64(data[len(data)-1].Time) - startTime
	plot.Y.Min = 0
	plot.Y.Max = 16000

	filename = filename + ".png"

	if err := plot.Save(5*vg.Inch, 3*vg.Inch, filename); err != nil {
		log.Fatal("failed to save plot", "err", err)
	}
}
