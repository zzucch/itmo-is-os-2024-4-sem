package main

import (
	"fmt"
	"os"
	"sync"
)

func create(wg *sync.WaitGroup, num int) {
	name := fmt.Sprintf("file_%d.txt", num)

	file, err := os.Create(name)
	if err != nil {
		panic(err)
	}

	for range num * 75000 {
		fmt.Fprintf(file, "%d\n", num)
	}

	file.Close()
	wg.Done()
}

func main() {
	var wg sync.WaitGroup

	for i := 1; i < 20; i++ {
		wg.Add(1)
		go create(&wg, i)
	}

	wg.Wait()
}
