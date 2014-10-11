package com.game.login.view
{
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.login.cfg.*;
    import com.game.login.control.*;
    import com.greensock.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.ui.*;

    public class RegistScene extends BaseScene
    {
        private var _job1Btn:BaseButton;
        private var _job2Btn:BaseButton;
        private var _job3Btn:BaseButton;
        private var btns:Buttons;
        private var _scrollEnterTxt:TextField;
        private var _nameText:TextField;
        private var _startBtn:BaseButton;
        private var _start_btn_effect:MovieClip;
        private var _rollBtn:BaseButton;
        private var _curJob:uint;
        private var _ticker:Ticker;
        private var _nameIdx:int;
        private var _curSex:uint = 1;
        private var _sexjob:Array;
        private const MAX_ROLL_CNT:uint = 5;
        private var _rollName:String;
        private var _rollCnt:uint = 0;
        private var canClick:Boolean = true;
        private var isFisitChangeJob:Boolean = true;
        public var inputTips:TextField;
        private var _names:Array;
        private var autoRegistTimerIsRunning:Boolean = false;
        private var _virtualChat:VirtualChat;
        private var names:Array;
        public static var _rolebgEffect:MovieClip;
        public static var isRandom:Boolean = true;
        public static var isRegisteSuccess:Boolean = false;
        public static var hanReturn:Boolean = true;
        private static var enableFilters:Array = [new ColorMatrixFilter(ColorFilter.saturationPer(-70))].concat(ColorFilter.brightness(-20));

        public function RegistScene()
        {
            var _loc_2:* = null;
            this._sexjob = [SEX_TYPE.MALE, SEX_TYPE.MALE, SEX_TYPE.FAMALE];
            this._names = ["黯然销魂", "五支烟", "骑乌龟撞火箭", "神奇5侠", "猫人", "羁羽鸦", "严选大帅哥", "蓝天的季节", "龙宫礼奈", "灯塔", "一线牵", "亚修", "景阳岗上挨过打", "癫乂小K", "愿梦", "聂风儿", "龙思奇", "二手帅男", "雨残君", "霸气的萝莉", "我出五万元", "超人", "担担面", "巫妖之王", "战魂123", "电信二区", "怪异鬼手", "火蓝刀锋", "鬼鬼", "一直那么强", "战争旋涡", "MVP", "媚舞~~", "欢欢无敌", "星星月", "哥有实力不怕", "农夫三拳", "牛Ｂ哄哄震山东", "一招不秒撒腿就跑", "臭鼠标拿开", "我是被逼的", "发型永不乱"];
            this.names = new Array();
            setWH(1000, 600);
            ClickStream.add(ClickStreamId.START_LOAD_REGIST_VIEW);
            loadDisplay(Params.registSceneSwfURL, true);
            var _loc_1:* = CfgManager.getInstance().getMap("q_login_talk");
            this._names = [];
            for each (_loc_2 in _loc_1)
            {
                
                this._names.push(_loc_2);
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            ClickStream.add(ClickStreamId.SHOW_REGIST_VIEW);
            initComponentUI("reg_panel");
            this.initUI();
            Layout.layoutMC(FrameworkGlobal.stage, this);
            this._nameIdx = Math.floor((this._names.length - 1) * Math.random());
            Ticker.registerTimer(1.5, this.tickerFun, this.tickComplete);
            this._rollBtn.addEvtListener(MouseEvent.CLICK, this.__onRollBtn);
            this._startBtn.addEvtListener(MouseEvent.CLICK, this.__start);
            FrameworkGlobal.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onStageKeyDown, false, 0, true);
            FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
            this.__onRollBtn();
            this.startAutoRegistTimer();
            IndexSwf.instance.hideTxt();
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.REGISTER_PANEL_LOADED));
            super.displayReady();
            return;
        }// end function

        private function startAutoRegistTimer() : void
        {
            if (!this.autoRegistTimerIsRunning)
            {
                this.autoRegistTimerIsRunning = true;
                Ticker.registerTimer(30, this.onAutoRegistTimerComplete, null, 1);
                FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.stopAutoRegistTimer);
            }
            return;
        }// end function

        private function stopAutoRegistTimer(event:Event = null) : void
        {
            if (this.autoRegistTimerIsRunning)
            {
                this.autoRegistTimerIsRunning = false;
                Ticker.killTimer(this.onAutoRegistTimerComplete);
                this.unlistenEventsForStopAutoRegistTimer();
            }
            return;
        }// end function

        private function unlistenEventsForStopAutoRegistTimer() : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.stopAutoRegistTimer);
            return;
        }// end function

        private function onAutoRegistTimerComplete() : void
        {
            this.autoRegistTimerIsRunning = false;
            this.unlistenEventsForStopAutoRegistTimer();
            this.__start(null, true);
            return;
        }// end function

        private function onStageKeyDown(event:KeyboardEvent) : void
        {
            if (event.charCode == Keyboard.ENTER)
            {
                this.__start();
            }
            return;
        }// end function

        private function tickComplete() : void
        {
            return;
        }// end function

        private function initUI() : void
        {
            this.btns = new Buttons();
            this.btns.horizontal = true;
            this._job1Btn = this.createJobButton(1);
            this._job2Btn = this.createJobButton(2);
            this._job3Btn = this.createJobButton(3);
            this.btns.addEvtListener(Event.CHANGE, this.__changeJob);
            this.inputTips = getDisplayChildByName("errTips");
            this.inputTips.alpha = 0;
            this._virtualChat = new VirtualChat(270, 175);
            this._virtualChat.move(7, 430);
            addChild(this._virtualChat);
            this._nameText = getDisplayChildByName("name_txt");
            this._nameText.maxChars = 5;
            this._nameText.addEventListener(Event.CHANGE, this.inputName);
            this._nameText.addEventListener(FocusEvent.FOCUS_IN, this.onNameTextFoucusIn);
            this._rollBtn = new BaseButton(getDisplayChildByName("roll_btn"));
            this._scrollEnterTxt = getDisplayChildByName("enter_txt");
            this._start_btn_effect = getDisplayChildByName("start_btn_effect");
            if (this._start_btn_effect != null)
            {
                var _loc_3:* = false;
                this._start_btn_effect.mouseEnabled = false;
                this._start_btn_effect.mouseChildren = _loc_3;
                this._start_btn_effect.play();
            }
            var _loc_1:* = getDisplayChildByName("start_btn_cover");
            if (_loc_1 != null)
            {
                var _loc_3:* = false;
                _loc_1.mouseEnabled = false;
                _loc_1.mouseChildren = _loc_3;
            }
            this._startBtn = new BaseButton(getDisplayChildByName("start_btn"));
            this._startBtn.addEvtListener(MouseEvent.MOUSE_OVER, this.onStartBtnMouseOverHandle);
            this._startBtn.addEvtListener(MouseEvent.MOUSE_OUT, this.onStartBtnMouseOutHandle);
            this._startBtn.setText("<b>" + LanguageCfgObj.getInstance().getByLoginIndex("1019") + "</b>");
            var _loc_2:* = Math.random() * 10 % 3;
            this.btns.selectIndex = _loc_2;
            this._curJob = this.btns.selectIndex + 1;
            return;
        }// end function

        private function createJobButton(param1:int) : BaseButton
        {
            var _loc_2:* = null;
            _loc_2 = new BaseButton(getDisplayChildByName("job" + param1 + "_btn"), true);
            var _loc_3:* = getDisplayChildByName("jobmc" + param1);
            var _loc_4:* = getDisplayChildByName("jobbg" + param1);
            _loc_2.obj = {jobId:param1, mc:_loc_3, bg:_loc_4};
            _loc_2.mouseChildren = false;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.onJobBtnRollOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.onJobBtnRollOut);
            this.btns.appendBtn(_loc_2);
            return _loc_2;
        }// end function

        private function onJobBtnRollOver(event:MouseEvent) : void
        {
            this.setJobBtnRollOvered(event.currentTarget as BaseButton, true);
            return;
        }// end function

        private function onJobBtnRollOut(event:MouseEvent) : void
        {
            this.setJobBtnRollOvered(event.currentTarget as BaseButton, false);
            return;
        }// end function

        private function setJobBtnRollOvered(param1:BaseButton, param2:Boolean) : void
        {
            if (param1.obj.jobId != this._curJob)
            {
                this.setJobHighlighted(param1, param2);
                if (!param2 && this["_job" + this._curJob + "Btn"])
                {
                    this.setJobHighlighted(this["_job" + this._curJob + "Btn"], true);
                }
            }
            return;
        }// end function

        private function setJobHighlighted(param1:BaseButton, param2:Boolean) : void
        {
            var _loc_3:* = param1.obj;
            var _loc_4:* = _loc_3.mc;
            var _loc_5:* = _loc_3.bg;
            if (_loc_4)
            {
                if (param2)
                {
                    _loc_4.filters = null;
                    _loc_4.alpha = 1;
                }
                else
                {
                    _loc_4.filters = enableFilters;
                    _loc_4.alpha = 0.8;
                }
            }
            if (_loc_5)
            {
                if (param2)
                {
                    var _loc_6:* = false;
                    this._job3Btn.obj.bg.visible = false;
                    this._job2Btn.obj.bg.visible = _loc_6;
                    this._job1Btn.obj.bg.visible = _loc_6;
                }
                _loc_5.visible = param2;
            }
            return;
        }// end function

        private function onStartBtnMouseOverHandle(event:MouseEvent) : void
        {
            if (this._start_btn_effect != null)
            {
                this._start_btn_effect.stop();
            }
            return;
        }// end function

        private function onStartBtnMouseOutHandle(event:MouseEvent) : void
        {
            if (this._start_btn_effect != null)
            {
                this._start_btn_effect.play();
            }
            return;
        }// end function

        private function onNameTextFoucusIn(event:FocusEvent) : void
        {
            ClickStream.add(ClickStreamId.INPUT_NAME);
            this.stopAutoRegistTimer();
            return;
        }// end function

        private function inputName(event:Event) : void
        {
            isRandom = false;
            return;
        }// end function

        private function resetClick() : void
        {
            this.canClick = true;
            return;
        }// end function

        private function __start(event:MouseEvent = null, param2:Boolean = false) : void
        {
            if (!this.canClick)
            {
                return;
            }
            if (!hanReturn)
            {
                return;
            }
            if (isRegisteSuccess)
            {
                return;
            }
            this.stopAutoRegistTimer();
            var _loc_3:* = ToolKit.checkRoleName(this._nameText.text);
            if (_loc_3.length == 0)
            {
                if (param2)
                {
                    ClickStream.add(ClickStreamId.AUTO_REGIST_WHEN_NO_OPERATION);
                }
                else
                {
                    ClickStream.add(ClickStreamId.REGIST);
                }
                RegistControl.getInstance().createRole(this._nameText.text, this._curSex, this._curJob);
                RegistControl.hasRigister = true;
                this.canClick = false;
                hanReturn = false;
                TweenLite.delayedCall(1.2, this.resetClick);
            }
            else
            {
                this.simpleTip(_loc_3);
            }
            return;
        }// end function

        public function simpleTip(param1:String) : void
        {
            this.inputTips.text = param1;
            this.inputTips.alpha = 1;
            TweenLite.to(this.inputTips, 3, {alpha:0});
            return;
        }// end function

        private function __onRollBtn(event:MouseEvent = null) : void
        {
            if (event)
            {
                ClickStream.add(ClickStreamId.RANDOM_NAME);
            }
            this._rollName = NameCfgObj.getInstance().getRandName(this._curSex);
            this._nameText.text = this._rollName;
            isRandom = true;
            if (this._rollCnt >= this.MAX_ROLL_CNT)
            {
                this._rollBtn.enabled = true;
                this._nameText.text = this._rollName;
                return;
            }
            var _loc_2:* = this;
            var _loc_3:* = this._rollCnt + 1;
            _loc_2._rollCnt = _loc_3;
            RegistControl.getInstance().checkNick(this._rollName);
            return;
        }// end function

        public function doRollNameRsp(param1:Boolean) : void
        {
            if (param1)
            {
                this._rollBtn.enabled = true;
                this._nameText.text = this._rollName;
                this._rollCnt = 0;
            }
            else
            {
                this.__onRollBtn();
            }
            return;
        }// end function

        private function __changeJob(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            Log.log(this.btns.selectIndex);
            if (this.isFisitChangeJob)
            {
                this.isFisitChangeJob = false;
            }
            else
            {
                ClickStream.add(ClickStreamId.CHOOSE_JOB);
            }
            this._curJob = this.btns.selectIndex + 1;
            for each (_loc_2 in this.btns.contents)
            {
                
                this.setJobHighlighted(_loc_2, _loc_2 == this.btns.selectBtn);
            }
            _loc_3 = this._sexjob[this.btns.selectIndex];
            if (this._curSex != _loc_3)
            {
                this._curSex = _loc_3;
                this.__onRollBtn();
            }
            return;
        }// end function

        private function tickerFun() : void
        {
            if (this.names.length >= 10)
            {
                this.names.shift();
            }
            var _loc_1:* = this;
            _loc_1._nameIdx = this._nameIdx + 1;
            this.names.push(this._names[this._nameIdx++]);
            this._virtualChat.objs = this.names;
            if (this._nameIdx == this._names.length)
            {
                this._nameIdx = 0;
            }
            return;
        }// end function

        override public function resize() : void
        {
            Layout.layoutMC(FrameworkGlobal.stage, this);
            return;
        }// end function

        override public function finalize() : void
        {
            Ticker.killTimer(this.tickerFun);
            if (this._start_btn_effect != null)
            {
                this._start_btn_effect.stop();
            }
            this.stopAutoRegistTimer();
            FrameworkGlobal.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onStageKeyDown);
            super.finalize();
            return;
        }// end function

    }
}
