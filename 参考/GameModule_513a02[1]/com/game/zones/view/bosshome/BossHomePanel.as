package com.game.zones.view.bosshome
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
    import com.game.backpack.model.*;
    import com.game.challenge.control.*;
    import com.game.challenge.event.*;
    import com.game.challenge.model.*;
    import com.game.costgoods.control.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.vip.consts.*;
    import com.game.vip.control.*;
    import com.game.zones.bean.*;
    import com.game.zones.control.*;
    import com.game.zones.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class BossHomePanel extends BaseBox implements IGuide
    {
        protected var TIPS_WORD:String;
        private var needArr:Array;
        private var awardsHbox:HBox;
        protected var _toolIcon:IconItem;
        private var _zoneTableInfo:ZonesTableVo;
        private var _txtCount:TextField;
        private var _bossArr:Array;
        private var _closeBtn:BaseButton;
        private var _needitemcount:int;
        private var _vipTxt:TextField;
        private var _enterBtn:BaseButton;
        private var _needTxt:TextField;
        private var _needItem:IconItem;
        private var _zoneServerInfo:ZoneTeamInfo;

        public function BossHomePanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            var _loc_8:* = null;
            this.TIPS_WORD = LanguageCfgObj.getInstance().getByIndex("11489");
            this.needArr = [];
            this._bossArr = [];
            loadDisplay("res/bosshome.swf");
            var _loc_5:* = GlobalCfgObj.getInstance().getBossHomeKey();
            var _loc_6:* = _loc_5.split(";");
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6.length)
            {
                
                _loc_8 = (_loc_6[_loc_7] as String).split("_");
                this.needArr[_loc_8[0]] = _loc_8[1];
                _loc_7++;
            }
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
                this.freshPanel();
            }
            return;
        }// end function

        override public function open() : void
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            super.open();
            this._zoneTableInfo = ZonesCloneCfg.getInstance().getCurZones(_loc_1, ZoneType.ZONES_BOSS_HOME);
            ZonesControl.getInstance().reqZoneTeamOpenToGame(this._zoneTableInfo.id);
            BossGuideControl.getInstance().bossInfo.addEvtListener(BossGuideEvent.UPDATEBOSS, this.freshInfo);
            BossGuideControl.getInstance().reqSelectChallengeToGame(1);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            BossGuideControl.getInstance().bossInfo.removeEvtListener(BossGuideEvent.UPDATEBOSS, this.freshInfo);
            this.guidePause(GuideConfigObj.getInstance().BOSS_HOME_1);
            return;
        }// end function

        private function initAwardsList() : void
        {
            this.awardsHbox = new HBox();
            this.awardsHbox.oneRow = 7;
            this.awardsHbox.intervalX = 9;
            this.awardsHbox.intervalY = 4;
            this.awardsHbox.horizontal = true;
            this.addChild(this.awardsHbox);
            this.awardsHbox.move(91, 350);
            return;
        }// end function

        private function freshInfo(event:BossGuideEvent = null) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = BossGuideControl.getInstance().bossInfo;
            if (_loc_2)
            {
                for (_loc_3 in this._bossArr)
                {
                    
                    (_loc_5[_loc_3] as BossHomeItem).updateInfo(_loc_2);
                }
            }
            return;
        }// end function

        private function freshPanel() : void
        {
            if (!this._zoneTableInfo)
            {
                return;
            }
            var _loc_1:* = this._zoneTableInfo.reward;
            this.setAwards(_loc_1);
            return;
        }// end function

        private function setAwards(param1:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            while (this.awardsHbox.contents.length)
            {
                
                this.awardsHbox.removeByIndex(0);
            }
            var _loc_2:* = param1.split(";");
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new IconItem("commonRewardBox2_40");
                _loc_6 = PropUtil.createItemByCfg(_loc_2[_loc_4]);
                _loc_5.image.move(4, 3);
                _loc_5.setWH(46, 46);
                _loc_5.setInfo(_loc_6);
                this.awardsHbox.add(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

        private function setBaseInfo() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (UILoaded && this._zoneServerInfo)
            {
                this._txtCount.text = (this.zoneServerInfo.enterMaxnum - this.zoneServerInfo.enternum).toString();
                if (this._zoneTableInfo)
                {
                    _loc_1 = this.TIPS_WORD;
                    _loc_2 = this.getNestUpVip();
                    _loc_3 = VipCfgObj.getInstance().bossHomeAdd(_loc_2);
                    _loc_1 = _loc_1.replace("X1", _loc_2.toString());
                    _loc_1 = _loc_1.replace("X2", this._zoneTableInfo.duplicate_name);
                    _loc_1 = _loc_1.replace("X3", _loc_3.toString());
                    StringTip.create(this._vipTxt, _loc_1);
                    _loc_4 = this._zoneTableInfo.need_item;
                    if (this._zoneTableInfo.need_item && this._zoneTableInfo.need_item != "" && this._zoneTableInfo.need_item != "0")
                    {
                        _loc_5 = _loc_4.split(";");
                        this._needitemcount = int(_loc_5[0]);
                        _loc_6 = PropUtil.createItemByCfg(int(_loc_5[0]));
                        _loc_7 = this.getNeedCost();
                        if (_loc_7 != 0)
                        {
                            this._needTxt.text = "×" + _loc_7;
                        }
                        else
                        {
                            this._needTxt.text = "";
                        }
                        _loc_6.num = 0;
                        this._needItem.setInfo(_loc_6);
                    }
                }
            }
            return;
        }// end function

        public function getNeedCost() : int
        {
            if ((this._zoneServerInfo.enternum + 1) <= this.needArr.length)
            {
                return this.needArr[(this._zoneServerInfo.enternum + 1)];
            }
            return 0;
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

        override protected function displayReady() : void
        {
            initBaseBoxUI("bosshomepanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._txtCount = getDisplayChildByName("txt_enter_count") as TextField;
            this._enterBtn = new BaseButton(getDisplayChildByName("btn_enter"));
            this._needTxt = getDisplayChildByName("enter_req_item_content");
            this._needItem = new IconItem(getDisplayChildByName("need_item"));
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._vipTxt = getDisplayChildByName("txt_vip");
            this._vipTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11493");
            addChild(this._needItem);
            this.registerGuide();
            this.setBaseInfo();
            this.initAwardsList();
            this.initMonsters();
            this.freshInfo(null);
            this.freshPanel();
            this.addlistener();
            return;
        }// end function

        private function initMonsters() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = BossGuideControl.getInstance().bossInfo.config;
            var _loc_3:* = 1;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                if ((_loc_1[_loc_4] as QMonsterBossQcfg).q_page == 4)
                {
                    _loc_2 = new BossHomeItem(getDisplayChildByName("bossGuide_" + _loc_3));
                    _loc_2.setConfig(_loc_4, _loc_1[_loc_4], _loc_3);
                    addChild(_loc_2);
                    this._bossArr[_loc_4] = _loc_2;
                    _loc_3++;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function addlistener() : void
        {
            this._vipTxt.addEventListener(MouseEvent.CLICK, this.__btnClick);
            this._enterBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._enterBtn:
                {
                    this.enterZone();
                    break;
                }
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                case this._vipTxt:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            if (!UILoaded)
            {
                return;
            }
            GuideMultiControl.getInstance().registerGuide(this._enterBtn, this, GuideConfigObj.getInstance().BOSS_HOME_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            if (param1 == GuideConfigObj.getInstance().BOSS_HOME_1)
            {
                GuideMultiControl.getInstance().hideGuide(GuideConfigObj.getInstance().BOSS_HOME_1);
            }
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

        private function enterZone() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (ZonesControl.getInstance().inBossHome())
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", BossHomeConsts.LANG_VER));
                return;
            }
            if (this._zoneServerInfo.enternum >= this._zoneServerInfo.enterMaxnum)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10005", BossHomeConsts.LANG_VER));
                return;
            }
            var _loc_1:* = PropUtil.createItemByCfg(this._needitemcount);
            var _loc_2:* = BossHomeModel.getInstance().isFirst;
            if (this.getNeedCost() > 0 && !_loc_2)
            {
                _loc_3 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10004", BossHomeConsts.LANG_VER), [(this._zoneServerInfo.enternum + 1), _loc_1.q_name, this.getNeedCost()]);
                _loc_4 = BackpackObj.getInstance().getItemCount(this._needitemcount);
                _loc_5 = this.getNeedCost();
                _loc_6 = _loc_5 - _loc_4 > 0 ? (_loc_5 - _loc_4) : (0);
                _loc_7 = ShopCfgObj.getInstance().getShopItemInfoFromInside(this._needitemcount);
                if (_loc_6 > 0)
                {
                    _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12310"), [_loc_1.q_name, _loc_6 * _loc_7.gold]);
                }
                CostGoodsControl.getInstance().openCost(_loc_1, _loc_3, [_loc_6, _loc_7.gold], this.yesToEnter);
            }
            else
            {
                this.enter();
            }
            return;
        }// end function

        private function yesToEnter(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            if (param1 > 0)
            {
                _loc_3 = param1 * param2;
                if (UserObj.getInstance().playerInfo.gold < _loc_3)
                {
                    MapControl.getInstance().showRechargeD();
                }
                else
                {
                    this.enter();
                }
            }
            else
            {
                this.enter();
            }
            return;
        }// end function

        private function enter() : void
        {
            ZonesControl.getInstance().reqZoneTeamEnterToGame(0, this._zoneTableInfo.id);
            ZonesControl.getInstance().intendToBossHome = true;
            setTimeout(function () : void
            {
                ZonesControl.getInstance().intendToBossHome = false;
                return;
            }// end function
            , 1000);
            return;
        }// end function

    }
}
