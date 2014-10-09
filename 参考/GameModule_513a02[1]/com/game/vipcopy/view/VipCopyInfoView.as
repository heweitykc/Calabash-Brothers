package com.game.vipcopy.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.autopk.controller.*;
    import com.game.map.model.*;
    import com.game.vipcopy.model.*;
    import com.game.zones.control.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class VipCopyInfoView extends Component
    {
        private const HIT_QUIT_INSTANCE:String;
        private var mc_boss:MovieClip;
        private var mc_step:MovieClip;
        private var btn1:BaseButton;
        private var txt_compelete:TextField;
        private var txt_des:TextField;
        private var txtduringtime:TextField;
        private var txt_title:TextField;
        private var txt:TextField;
        private var enterTime:int = 0;
        private var copyIdArray:Array;
        private var hasFilter:Boolean = false;
        private var _downTime:int = 0;

        public function VipCopyInfoView(param1 = null, param2:String = null)
        {
            this.HIT_QUIT_INSTANCE = LanguageCfgObj.getInstance().getByIndex("11685");
            this.copyIdArray = [3007, 3008, 3009];
            super(param1, param2);
            loadDisplay("res/vipCopyInfo.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("vipCopyInfoPanel");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_boss = getDisplayChildByName("mc_boss");
            this.mc_step = getDisplayChildByName("mc_step");
            this.txt_compelete = getDisplayChildByName("txt_compelete");
            this.txt_des = getDisplayChildByName("txt_des");
            this.txtduringtime = getDisplayChildByName("txtduringtime");
            this.txt_title = getDisplayChildByName("txt_title");
            this.txt = getDisplayChildByName("txt");
            this.txt.mouseEnabled = false;
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.txt.text = LanguageCfgObj.getInstance().getByIndex("11415");
            var _loc_1:* = VipCopyData.copyMapIdArray;
            var _loc_2:* = MapObj.getInstance().mapID;
            var _loc_3:* = _loc_1.indexOf(_loc_2);
            if (_loc_3 > -1)
            {
                VipCopyData.getInstance().curSelect = _loc_3 + 1;
            }
            this.update();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    if (this.txt.text == LanguageCfgObj.getInstance().getByIndex("11415"))
                    {
                        AutoFightController.getInstance().openAutoFight();
                        this.txt.text = LanguageCfgObj.getInstance().getByIndex("11417");
                    }
                    else
                    {
                        AutoFightController.getInstance().closeAutoFight();
                        this.txt.text = LanguageCfgObj.getInstance().getByIndex("11415");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickQuit() : void
        {
            var _loc_1:* = this.HIT_QUIT_INSTANCE;
            Global.popManager.cue(_loc_1, "", null, this.callClickYes);
            return;
        }// end function

        private function callClickYes() : void
        {
            ZonesControl.getInstance().reqZoneOut();
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (UILoaded)
            {
                this.txtduringtime.text = ToolKit.getTimeBySecond(this.enterTime);
                this.mc_boss.gotoAndStop(VipCopyData.getInstance().curSelect);
                _loc_1 = RoleList.getInstance().roles;
                this.txt_compelete.text = LanguageCfgObj.getInstance().getByIndex("11419");
                this.mc_step.gotoAndStop(1);
                this.txt_title.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12296"), [VipCopyData.getInstance().curSelect]);
                _loc_2 = ZonesCloneCfg.getInstance().getZonesInfoFromId(this.copyIdArray[(VipCopyData.getInstance().curSelect - 1)]);
                _loc_3 = _loc_2.condition_explain.split("|");
                _loc_4 = UserObj.getInstance().playerInfo.level;
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length)
                {
                    
                    _loc_6 = String(_loc_3[_loc_5]).split("_");
                    if (int(_loc_6[0] <= _loc_4 && _loc_4 <= _loc_6[1]))
                    {
                        this.txt_des.htmlText = _loc_6[2];
                    }
                    _loc_5++;
                }
            }
            return;
        }// end function

        public function updateDownTime(param1:int) : void
        {
            this._downTime = param1;
            if (this.txtduringtime)
            {
                this.txtduringtime.text = "" + ToolKit.getTimeBySecond(this._downTime);
            }
            Ticker.killTimer(this.timeHandler);
            Ticker.registerTimer(1, this.timeHandler);
            return;
        }// end function

        private function timeHandler() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (this._downTime > 0)
            {
                var _loc_5:* = this;
                var _loc_6:* = this._downTime - 1;
                _loc_5._downTime = _loc_6;
            }
            if (this.txtduringtime)
            {
                this.txtduringtime.text = "" + ToolKit.getTimeBySecond(this._downTime);
                _loc_1 = RoleList.getInstance().roles;
                _loc_2 = 0;
                for each (_loc_3 in _loc_1)
                {
                    
                    _loc_4 = _loc_3 as IRole;
                    if (_loc_4 && _loc_4.info && !_loc_4.info.owner)
                    {
                        _loc_2++;
                    }
                }
                this.txt_compelete.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12297"), [2 - _loc_2 + "/1"]);
                if ((_loc_2 - 1) == 0)
                {
                    this.mc_step.gotoAndStop(101);
                    if (!this.hasFilter)
                    {
                        this.hasFilter = true;
                        ZonesControl.getInstance().addFilterZonesIconQuit(true);
                    }
                }
                else if ((_loc_2 - 1) == 1)
                {
                    this.mc_step.gotoAndStop(1);
                }
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, -140, 170));
            this.hasFilter = false;
            this.update();
            return;
        }// end function

        public function close() : void
        {
            Global.mainUIManager.removeUI(this);
            ZonesControl.getInstance().addFilterZonesIconQuit(false);
            Ticker.killTimer(this.timeHandler);
            return;
        }// end function

    }
}
