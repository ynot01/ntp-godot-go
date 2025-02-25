package main

import (
	"fmt"
	"math/rand"

	"github.com/beevik/ntp"
	"graphics.gd/classdb"
	"graphics.gd/classdb/Engine"
	"graphics.gd/startup"
	"graphics.gd/variant/Object"
)

type NTP struct {
	classdb.Extension[NTP, Object.Instance] `gd:"NTP"`
}

var ntp_servers = [...]string{
	"time.cloudflare.com",
	// Add servers here
}

func Now() int64 {
	if len(ntp_servers) == 0 {
		Engine.Raise(fmt.Errorf("no NTP servers are available for selection"))
		return 0
	}
	selected_server := ntp_servers[rand.Intn(len(ntp_servers))]
	time, err := ntp.Time(selected_server)
	if err != nil {
		Engine.Raise(err)
		return 0
	}
	return time.UnixMilli()
}

func main() {
	classdb.Register[NTP](
		map[string]any{
			"now": Now,
		},
	)
	startup.Scene()
}
