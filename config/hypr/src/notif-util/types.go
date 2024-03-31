package notifutil

type WaybarClassType int

type WaybarStruct struct {
	Class   string `json:"class"`
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
}

type DunstNotifProps struct {
	AppName string `json:"app_name"`
	Summary string `json:"summary"`
	Urgency string `json:"urgency"`
	// Body         string `json:"body"`
	// IconPath     string `json:"icon_path"`
	// Id           string `json:"id"`
	// Progress     string `json:"progress"`
	// Category     string `json:"category"`
	// StackTag     string `json:"stack_tag"`
	// URLs         string `json:"ur_ls"`
	// Timeout      string `json:"timeout"`
	// Timestamp    string `json:"timestamp"`
	// DesktopEntry string `json:"desktop_entry"`
}

const (
	ClassLow WaybarClassType = iota
	ClassNormal
	ClassCritical
	ClassPlaying
	ClassPaused
)

var waybarClassString = [5]string{
	ClassLow:      "low",
	ClassNormal:   "normal",
	ClassCritical: "critical",
	ClassPlaying:  "playing",
	ClassPaused:   "paused",
}

func (w WaybarClassType) String() string {
	if w <= ClassPaused && w >= ClassLow {
		return waybarClassString[w]
	}
	return waybarClassString[ClassNormal]
}
