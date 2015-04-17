package com.sempaigames.gplayrest.ui;

import com.sempaigames.gplayrest.GPlay;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;

class UIManager {

	static var instance : UIManager = null;
	var viewsStack : Array<UI>;

	public static function getInstance() {
		if (instance==null) {
			instance = new UIManager();
		}
		return instance;
	}

	function new() {
		viewsStack = [];
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		Lib.current.stage.addEventListener(Event.RESIZE, onResize);
	}

	function currentView() {
		return ;
	}

	function onKeyUp(e : KeyboardEvent) {
		var v = viewsStack[viewsStack.length-1];
		if (v!=null) {
			v.onKeyUp(e);
		}
	}

	function onResize(e : Event) {
		var v = viewsStack[viewsStack.length-1];
		if (v!=null) {
			v.onResize(e);
		}
	}

	public function showAchievements(gplay : GPlay) {
		var v = new AchievementsUI(gplay);
		viewsStack.push(v);
		Lib.current.stage.addChild(v);
		v.onResize(null);
	}

	public function showAllLeaderboards(gplay : GPlay) {
		var v = new AllLeaderboardsUI(gplay);
		viewsStack.push(v);
		Lib.current.stage.addChild(v);
		v.onResize(null);
	}

	public function showLeaderboard(gplay : GPlay, id : String) {
		var v = new LeaderboardUI(gplay, id);
		viewsStack.push(v);
		Lib.current.stage.addChild(v);
		v.onResize(null);
	}

	public function closeCurrentView() {
		if (viewsStack.length>0) {
			var v = viewsStack.pop();
			Lib.current.stage.removeChild(v);
			v.onClose();
		}
	}

}