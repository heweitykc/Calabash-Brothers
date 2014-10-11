package com.game.greedisland.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.elementHeart.model.*;
    import com.game.greedisland.control.*;
    import com.game.primaryrole.control.*;
    import com.game.vip.consts.*;
    import com.game.vip.control.*;
    import com.game.zones.bean.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;

    public class IslandBox extends BaseBox
    {
        private var btn_close:BaseButton;
        private var btn_enter:BaseButton;
        private var txt_enter_count:TextField;
        private var btn_vip:BaseButton;
        private var awardsHbox:HBox;
        protected var _zoneTableInfo:ZonesTableVo;
        protected var _txtZonesCD:TextField;
        protected var _txtZonesCDtitle:TextField;
        protected var _txtCleanBtn:TextField;
        protected var _btnClean:BaseButton;
        protected var TIPS_WORD:String;
        private var _zoneServerInfo:ZoneTeamInfo;
        protected var _cdEnter:DownTimer;
        protected var _isCD:Boolean = false;
        private static var HIT_CLEARCD:String = LanguageCfgObj.getInstance().getByIndex("11525");

        public function IslandBox()
        {
            this.TIPS_WORD = LanguageCfgObj.getInstance().getByIndex("11489");
            this._cdEnter = new DownTimer();
            loadDisplay("res/islandbox.swf");
            _peaceBox = ["*"];
            return;
        }// end function

        public function get zoneServerInfo() : ZoneTeamInfo
        {
            return this._zoneServerInfo;
        }// end function

        public function set zoneServerInfo(param1:ZoneTeamInfo) : void
        {
            this._zoneServerInfo = param1;
            this.setBaseInfo();
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("islandBox");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_close = new BaseButton(getDisplayChildByName("btn_close"));
            this.btn_enter = new BaseButton(getDisplayChildByName("btn_enter"));
            this.btn_enter.setText(LanguageCfgObj.getInstance().getByIndex("10000", "lang_island"));
            this.txt_enter_count = getDisplayChildByName("txt_enter_count");
            this.btn_vip = new BaseButton(getDisplayChildByName("btn_vip"));
            this._btnClean = new BaseButton(getDisplayChildByName("btn_clean"));
            this._btnClean.setText(LanguageCfgObj.getInstance().getByIndex("11492"));
            this._txtCleanBtn = TextField(getDisplayChildByName("txt_clean_btn"));
            this._txtCleanBtn.mouseEnabled = false;
            this._txtZonesCD = getDisplayChildByName("txt_zones_cd") as TextField;
            this._txtZonesCDtitle = getDisplayChildByName("txt_zones_cd_title") as TextField;
            this._cdEnter.callBack = this.callCDback;
            this.awardsHbox = new HBox();
            this.awardsHbox.oneRow = 4;
            this.awardsHbox.intervalX = 21;
            this.awardsHbox.intervalY = 8;
            this.awardsHbox.horizontal = true;
            this.addChild(this.awardsHbox);
            this.awardsHbox.move(121, 315);
            this._zoneTableInfo = ZonesCloneCfg.getInstance().getZonesInfoFromId(Params.ISLAND_COPY_ID);
            if (this.btn_close)
            {
                this.btn_close.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.update();
            this.reqData();
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_enter.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_vip.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this._btnClean.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var leftNum:int;
            var str1:String;
            var str2:String;
            var str3:String;
            var e:* = event;
            switch(e.target)
            {
                case this.btn_enter:
                {
                    if (this._isCD)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11494"));
                        return;
                    }
                    leftNum = this.zoneServerInfo.enterMaxnum - this.zoneServerInfo.enternum;
                    if (leftNum > 0)
                    {
                        if (ElementHeartData.getInstance().isFull())
                        {
                            str1 = LanguageCfgObj.getInstance().getByIndex("10022", "lang_island");
                            str2 = LanguageCfgObj.getInstance().getByIndex("10023", "lang_island");
                            str3 = LanguageCfgObj.getInstance().getByIndex("10024", "lang_island");
                            Global.popManager.cue(str1, null, null, function () : void
            {
                PrimaryRoleControl.getInstance().openElementHeart();
                close();
                return;
            }// end function
            , function () : void
            {
                if (zoneServerInfo.enternum <= 1)
                {
                    IslandControl.getInstance().reqEnterIslandCopy();
                    close();
                }
                else
                {
                    IslandControl.getInstance().openIslandCopySurePanel();
                }
                return;
            }// end function
            , 2, [str2, str3]);
                        }
                        else if (this.zoneServerInfo.enternum <= 1)
                        {
                            IslandControl.getInstance().reqEnterIslandCopy();
                            close();
                        }
                        else
                        {
                            IslandControl.getInstance().openIslandCopySurePanel();
                        }
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", "lang_island"));
                    }
                    break;
                }
                case this.btn_vip:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case this._btnClean:
                {
                    this.cleanZonesCD();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function cleanZonesCD() : void
        {
            var _loc_1:* = this._cdEnter.count / 1000;
            if (_loc_1 <= 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11497"));
                return;
            }
            var _loc_2:* = Math.floor(this._cdEnter.count / (1000 * 30));
            var _loc_3:* = HIT_CLEARCD.replace("#", _loc_2.toString());
            Global.popManager.cue(_loc_3, "", null, this.callCleanCD);
            return;
        }// end function

        private function callCleanCD() : void
        {
            ZonesControl.getInstance().reqclearZoneCD(Params.ISLAND_COPY_ID);
            return;
        }// end function

        public function clearCD() : void
        {
            this._cdEnter.count = 0;
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function update() : void
        {
            this.setAwards();
            return;
        }// end function

        protected function setBaseInfo() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (UILoaded && this._zoneServerInfo)
            {
                this.txt_enter_count.text = (this.zoneServerInfo.enterMaxnum - this.zoneServerInfo.enternum).toString();
                if (this._zoneTableInfo)
                {
                    _loc_2 = this.TIPS_WORD;
                    _loc_3 = this.getNestUpVip();
                    _loc_4 = VipCfgObj.getInstance().dungeonAdd(_loc_3);
                    _loc_2 = _loc_2.replace("X1", _loc_3.toString());
                    _loc_2 = _loc_2.replace("X2", this._zoneTableInfo.duplicate_name);
                    _loc_2 = _loc_2.replace("X3", _loc_4.toString());
                    StringTip.create(this.btn_vip, _loc_2);
                }
                _loc_1 = int(this._zoneServerInfo.wait_time.toNumber() - (ToolKit.getServerTime() - this._zoneServerInfo.last_time.toNumber()));
                if (_loc_1 > 0 && this._zoneServerInfo.isopen == 3)
                {
                    this._cdEnter.count = _loc_1;
                    this._isCD = true;
                    this.btn_enter.filters = [ColorFilter.getGrayFilter()];
                    this.btn_enter.mouseEnabled = false;
                    this._btnClean.visible = true;
                    this._txtCleanBtn.visible = true;
                }
                else
                {
                    this._cdEnter.count = 0;
                    this._btnClean.visible = false;
                    this._txtCleanBtn.visible = false;
                    this.btn_enter.filters = [];
                    this.btn_enter.mouseEnabled = true;
                }
            }
            return;
        }// end function

        protected function getNestUpVip() : int
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.vipid;
            var _loc_2:* = VipCfgObj.getInstance().dungeonAdd(_loc_1);
            var _loc_3:* = _loc_1 + 1;
            while (_loc_3 <= VipConst.VIP_MAX_LEVEL)
            {
                
                if (VipCfgObj.getInstance().dungeonAdd(_loc_3) > _loc_2)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        private function setAwards() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_1:* = this._zoneTableInfo.reward;
            while (this.awardsHbox.contents.length)
            {
                
                this.awardsHbox.removeByIndex(0);
            }
            var _loc_2:* = _loc_1.split("|");
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                _loc_6 = _loc_5.split("_");
                _loc_7 = UserObj.getInstance().playerInfo.level;
                if (_loc_7 >= _loc_6[0] && _loc_7 <= _loc_6[1])
                {
                    _loc_8 = _loc_6[2].split(";");
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8.length)
                    {
                        
                        _loc_10 = new IconItem("commonRewardBox2_40");
                        _loc_11 = PropUtil.createItemByCfg(_loc_8[_loc_9]);
                        _loc_10.image.move(4, 3);
                        _loc_10.setWH(46, 46);
                        _loc_10.setInfo(_loc_11);
                        this.awardsHbox.add(_loc_10);
                        _loc_9++;
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function setDes() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = this._zoneTableInfo.condition_explain;
            var _loc_2:* = _loc_1.split("|");
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                _loc_6 = _loc_5.split("_");
                _loc_7 = UserObj.getInstance().playerInfo.level;
                if (_loc_7 >= _loc_6[0] && _loc_7 <= _loc_6[1])
                {
                }
                _loc_4++;
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.update();
                this.reqData();
            }
            return;
        }// end function

        private function callCDback(param1:int, param2:String) : void
        {
            this._txtZonesCD.text = param2.substr(3, param2.length);
            if (param1 <= 0)
            {
                this._txtZonesCD.text = "";
                this._isCD = false;
                this._btnClean.visible = false;
                this._txtCleanBtn.visible = false;
                this.btn_enter.filters = [];
                this.btn_enter.mouseEnabled = true;
            }
            return;
        }// end function

        public function reqData() : void
        {
            ZonesControl.getInstance().reqZoneTeamOpenToGame(Params.ISLAND_COPY_ID);
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
