package com.game.movie
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.f1.view.mapeditor.*;
    import com.game.role.*;
    import com.game.task.*;
    import com.game.task.view.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import interfaces.movie.*;
    import interfaces.role.*;

    public class MoviePlayer extends BaseScene implements IMovie
    {
        private var _movieID:String;
        private var _cfg:MovieCfg;
        private var _closeBtn:BaseButton;
        private var bgView:GameBgView;
        private var rolesConatiner:Sprite;
        private var itemIdx:int;
        private var currentSpeaker:SimpleRole;
        private var progressBox:UILoadingBox;
        private var _curSWF:BaseSprite;
        public static const SIDE_LEFT:uint = 1;
        public static const SIDE_RIGHT:uint = 2;
        public static var instance:MoviePlayer;

        public function MoviePlayer(param1:String)
        {
            this.rolesConatiner = new Sprite();
            this.graphics.beginFill(0, 1);
            this.graphics.drawRect(0, 0, FrameworkGlobal.stageW, FrameworkGlobal.stageH);
            this.graphics.endFill();
            this._movieID = param1;
            loadDisplay("res/talkbox.swf");
            FrameworkGlobal.stage.addEventListener(Event.RESIZE, this.resizeHandle);
            return;
        }// end function

        override protected function displayReady() : void
        {
            VResManager.load(Params.MOVIE_PATH + this._movieID + ".xml", this.loadMovieCfgComplete, null, this.loadErr);
            super.displayReady();
            return;
        }// end function

        private function loadErr() : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function loadMovieCfgComplete(param1:String) : void
        {
            var _loc_2:* = XML(param1);
            this._cfg = this.prase(_loc_2);
            this.initUI();
            this.resize();
            this.start();
            return;
        }// end function

        private function resizeHandle(event:Event) : void
        {
            this.resize();
            return;
        }// end function

        private function prase(param1:XML) : MovieCfg
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = new MovieCfg();
            _loc_2.scene = param1.bg[0];
            _loc_2.sceneX = param1.bg.@x;
            _loc_2.sceneY = param1.bg.@y;
            _loc_2.roleList = new Vector.<SimpleRole>;
            var _loc_3:* = param1.left.role;
            for each (_loc_5 in _loc_3)
            {
                
                _loc_4 = this.addRole(_loc_5);
                _loc_2.roleList.push(_loc_4);
            }
            _loc_3 = param1.right.role;
            for each (_loc_5 in _loc_3)
            {
                
                _loc_4 = this.addRole(_loc_5, true);
                _loc_2.roleList.push(_loc_4);
            }
            _loc_2.steps = new Vector.<XML>;
            _loc_6 = param1.movie.item;
            for each (_loc_7 in _loc_6)
            {
                
                _loc_2.steps.push(_loc_7);
            }
            return _loc_2;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this.bgView = new GameBgView();
            this.bgView.update(Params.MAP_PATH + this._cfg.scene + ".bin", this.__setComplete);
            addChild(this.bgView);
            this.bgView.move(-this._cfg.sceneX, -this._cfg.sceneY);
            addChild(this.rolesConatiner);
            var _loc_1:* = this._cfg.roleList.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this.rolesConatiner.getChildIndex(this._cfg.roleList[_loc_2]);
                _loc_4 = _loc_2 + 1;
                while (_loc_4 < _loc_1)
                {
                    
                    _loc_5 = this.rolesConatiner.getChildIndex(this._cfg.roleList[_loc_4]);
                    this.rolesConatiner.getChildIndex(this._cfg.roleList[_loc_4]);
                    if (this._cfg.roleList[_loc_2].y < this._cfg.roleList[_loc_4].y != _loc_3 < _loc_5)
                    {
                        this.rolesConatiner.swapChildren(this._cfg.roleList[_loc_2], this._cfg.roleList[_loc_4]);
                    }
                    _loc_4++;
                }
                _loc_2++;
            }
            this._closeBtn = new BaseButton(ToolKit.getNew("generalLowRed_btn"));
            this._closeBtn.setText(LanguageCfgObj.getInstance().getByIndex("10960"));
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__onCloseBtn, false, true);
            addChild(this._closeBtn);
            return;
        }// end function

        private function __onCloseBtn(event:MouseEvent) : void
        {
            this.playComplete();
            this.finalize();
            return;
        }// end function

        private function __setComplete() : void
        {
            this.resize();
            return;
        }// end function

        override public function resize() : void
        {
            super.resize();
            layoutMC(this.bgView, 1, this._cfg.sceneX, this._cfg.sceneY);
            layoutMC(this._closeBtn, Layout.BOTTOM_RIGHT, 15, 15);
            if (this._curSWF)
            {
                layoutMC(this._curSWF);
            }
            return;
        }// end function

        private function addRole(param1:XML, param2:Boolean = false) : SimpleRole
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            if (String(param1.@pri) == "true")
            {
                _loc_3 = UserObj.getInstance().playerInfo;
            }
            else
            {
                if (String(param1.cfgID))
                {
                }
                else
                {
                    _loc_3 = new RoleInfo();
                }
                _loc_3.name = param1.name;
                _loc_3.speed = 400;
            }
            var _loc_4:* = String(param1.showID);
            if (String(param1.showID) == "")
            {
                _loc_4 = UserObj.getInstance().playerInfo.showID;
            }
            _loc_3.showID = _loc_4.substring(1);
            var _loc_6:* = _loc_4.charAt();
            _loc_3.headPic = Params.ROLE_HEAD_PATH + _loc_4 + ".png";
            _loc_3.bigHeadPic = "h" + Params.ROLE_BIG_HEAD_PATH + _loc_4 + ".png";
            _loc_3.personId = new long();
            switch(_loc_6)
            {
                case "m":
                {
                    _loc_3.url = Params.ROLE_RES_PATH + _loc_4;
                    _loc_5 = Global.roleFactory.creatRole(_loc_3);
                    break;
                }
                case "a":
                {
                    _loc_3.url = Params.ROLE_RES_PATH + _loc_4;
                    _loc_5 = Global.roleFactory.creatRole(_loc_3);
                    break;
                }
                default:
                {
                    _loc_3.url = Params.ROLE_RES_PATH + _loc_4;
                    _loc_5 = Global.roleFactory.creatRole(_loc_3);
                    break;
                    break;
                }
            }
            if (param2)
            {
                _loc_5.direct = -FrameworkGlobal.DIRECT_90;
                _loc_5.info.side = SIDE_RIGHT;
            }
            else
            {
                _loc_5.direct = FrameworkGlobal.DIRECT_90;
                _loc_5.info.side = SIDE_LEFT;
            }
            var _loc_7:* = param1.stand.split("|");
            var _loc_8:* = int(_loc_7[0]);
            var _loc_9:* = int(_loc_7[1]);
            if (_loc_8 < 0)
            {
                if (param2)
                {
                    _loc_8 = _w + _loc_5.getSprite().width;
                }
                else
                {
                    _loc_8 = -_loc_5.getSprite().width;
                }
            }
            _loc_5.move(_loc_8, _loc_9);
            this.rolesConatiner.addChild(_loc_5.getSprite());
            return _loc_5 as SimpleRole;
        }// end function

        private function start() : void
        {
            addEventListener(Event.ENTER_FRAME, this.__enterframe);
            this.itemIdx = 0;
            TweenLite.delayedCall(2, this.doItem);
            return;
        }// end function

        private function doItem() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_1:* = this._cfg.steps[this.itemIdx];
            if (String(_loc_1.run) != "")
            {
                for (_loc_4 in _loc_1.role)
                {
                    
                    _loc_5 = int(_loc_14[_loc_4]) - 1;
                    _loc_3 = this._cfg.roleList[_loc_5];
                    if (_loc_3)
                    {
                        _loc_2 = _loc_1.run[_loc_4].split("|");
                        _loc_6 = int(_loc_2[0]);
                        _loc_7 = int(_loc_2[1]);
                        if (_loc_6 == -1)
                        {
                            if (_loc_3.info.side == SIDE_LEFT)
                            {
                                _loc_6 = -_loc_3.getSprite().width;
                            }
                            else
                            {
                                _loc_6 = _w + _loc_3.getSprite().width;
                            }
                        }
                        else if (_loc_6 == -2)
                        {
                            if (_loc_3.info.side == SIDE_LEFT)
                            {
                                _loc_6 = _w + _loc_3.getSprite().width;
                            }
                            else
                            {
                                _loc_6 = -_loc_3.getSprite().width;
                            }
                        }
                        _loc_3.pathByCoo(_loc_6, _loc_7, 0, 0, false, false);
                        continue;
                    }
                    Global.popManager.cue("剧情播放出错" + this._movieID, "", null, this.playComplete, null, 1);
                }
                if (_loc_3)
                {
                    _loc_3.addEvtListener(RoleEvent.ARRIVE, this.__nextItem);
                }
            }
            if (this.currentSpeaker)
            {
                this.currentSpeaker.stopSpeak();
            }
            if (String(_loc_1.speak) != "")
            {
                _loc_5 = _loc_14[0] - 1;
                _loc_3 = this._cfg.roleList[_loc_5];
                if (_loc_3)
                {
                }
                else
                {
                    Global.popManager.cue("剧情播放出错" + this._movieID, "", null, this.playComplete, null, 1);
                }
                _loc_8 = String(_loc_1.speak);
                _loc_9 = this._cfg.roleList.length;
                _loc_11 = 1;
                while (_loc_11 <= _loc_9)
                {
                    
                    if (_loc_11 == 1)
                    {
                        _loc_10 = SimpleRole(this._cfg.roleList[(_loc_11 - 1)]).info.sex == SEX_TYPE.MALE ? ("少侠") : ("女侠");
                        _loc_8 = _loc_8.replace("${pri}", _loc_10);
                    }
                    _loc_10 = SimpleRole(this._cfg.roleList[(_loc_11 - 1)]).info.name;
                    _loc_8 = _loc_8.replace("${" + _loc_11 + "}", _loc_10);
                    _loc_11++;
                }
                this.currentSpeaker = _loc_3;
                this.currentSpeaker.speak(_loc_8);
                TweenLite.delayedCall(2, this.__speakOver);
            }
            if (String(_loc_1.swf) != "")
            {
                if (this.rolesConatiner && this.rolesConatiner.parent)
                {
                    removeChild(this.rolesConatiner);
                }
                if (this.bgView && this.bgView.parent)
                {
                    removeChild(this.bgView);
                }
                if (!this.progressBox)
                {
                    this.progressBox = new UILoadingBox();
                    Global.popManager.addPop(this.progressBox, false, false, true, true, false, true);
                }
                _loc_12 = String(_loc_1.swf);
                VResManager.load(_loc_12, this.__loadSwfComplete, null, null, this.progressBox.setProgress);
                this.progressBox.open();
            }
            return;
        }// end function

        private function __loadSwfComplete(param1:MovieClip) : void
        {
            this._curSWF = new BaseSprite();
            this._curSWF.addChild(param1);
            addChild(this._curSWF);
            this._curSWF.setWH(1260, 690);
            this.progressBox.close();
            this.resize();
            FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.__playSwfComplete, false, 0, true);
            this._curSWF.addEventListener("complete", this.__playSwfComplete, true);
            return;
        }// end function

        private function __playSwfComplete(event:Event = null) : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__playSwfComplete);
            this._curSWF.removeEventListener("complete", this.__playSwfComplete);
            ToolKit.clearMcChild(this._curSWF);
            this._curSWF = null;
            if (this.bgView)
            {
                addChildAt(this.bgView, 0);
            }
            if (this.rolesConatiner)
            {
                addChildAt(this.rolesConatiner, 1);
            }
            this.__nextItem();
            return;
        }// end function

        private function __speakOver() : void
        {
            if (FrameworkGlobal.stage)
            {
                FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.__clickStage, false, 0, true);
            }
            TweenLite.delayedCall(2, this.__nextItem);
            return;
        }// end function

        private function __clickStage(event:MouseEvent) : void
        {
            TweenLite.killDelayedCallsTo(this.__nextItem);
            if (FrameworkGlobal.stage)
            {
                FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__clickStage);
            }
            this.__nextItem();
            return;
        }// end function

        public function __nextItem(event:Event = null) : void
        {
            TweenLite.killDelayedCallsTo(this.__nextItem);
            var _loc_2:* = this;
            var _loc_3:* = this.itemIdx + 1;
            _loc_2.itemIdx = _loc_3;
            if (this.itemIdx < this._cfg.steps.length)
            {
                this.doItem();
            }
            else if (this.itemIdx == this._cfg.steps.length)
            {
                this.playComplete();
            }
            return;
        }// end function

        private function playComplete() : void
        {
            if (FrameworkGlobal.stage)
            {
                FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__clickStage);
            }
            TweenLite.killDelayedCallsTo(this.__nextItem);
            TweenLite.killDelayedCallsTo(this.__speakOver);
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function __enterframe(event:Event) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._cfg.roleList)
            {
                
                _loc_2.enterFrame();
            }
            return;
        }// end function

        override public function finalize() : void
        {
            Log.log("清理剧情场景,preScene=" + this.preScene + ",nextScene=" + this.nextScene);
            if (FrameworkGlobal.stage)
            {
                FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__clickStage);
                FrameworkGlobal.stage.removeEventListener(Event.RESIZE, this.resizeHandle);
            }
            super.finalize();
            return;
        }// end function

        public static function play(param1:String) : void
        {
            stop();
            instance = new MoviePlayer(param1);
            instance.addEventListener(Event.COMPLETE, stop);
            Global.sceneManager.container.addChild(instance);
            FastTaskPanel.getInstance().visible = false;
            TaskGlobal.autoTask = false;
            return;
        }// end function

        public static function stop(event:Event = null) : void
        {
            if (instance)
            {
                instance.removeEventListener(Event.COMPLETE, stop);
                if (Global.sceneManager.container.contains(instance))
                {
                    Global.sceneManager.container.removeChild(instance);
                }
                instance.finalize();
                instance = null;
            }
            FastTaskPanel.getInstance().visible = true;
            TaskGlobal.autoTask = true;
            return;
        }// end function

    }
}

import com.*;

import com.events.*;

import com.f1.*;

import com.f1.manager.resource.*;

import com.f1.ui.*;

import com.f1.ui.btn.*;

import com.f1.utils.*;

import com.f1.view.mapeditor.*;

import com.game.role.*;

import com.game.task.*;

import com.game.task.view.*;

import com.game.utils.*;

import com.greensock.*;

import com.model.*;

import com.model.vo.*;

import com.staticdata.*;

import flash.display.*;

import flash.events.*;

import interfaces.movie.*;

import interfaces.role.*;

class MovieCfg extends Object
{
    public var id:String;
    public var scene:String;
    public var sceneX:int;
    public var sceneY:int;
    public var roleList:Vector.<SimpleRole>;
    public var steps:Vector.<XML>;

    function MovieCfg()
    {
        return;
    }// end function

}

