package com.game.map.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.desktop.control.*;
    import com.game.gameStrategy.controll.*;
    import com.game.mail.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.viewItem.*;
    import com.game.prompt.utils.*;
    import com.game.settings.*;
    import com.game.sound.control.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class MiniMap extends Component
    {
        private var _leadInfo:PlayerInfo;
        private const LIMIT_LEVEL:uint = 70;
        private var _mapNameTxt:TextField;
        private var _posTxt:TextField;
        private var _mapBtn:BaseButton;
        private var _lineBtn:BaseButton;
        private var _officalWebTxt:TextField;
        private var _forumTxt:TextField;
        private var _GMTxt:TextField;
        private var _eyeMc:BaseButton;
        private var _soundMc:BaseButton;
        private var _mailMc:BaseButton;
        private var _mailCount:Sprite;
        private var _setMc:BaseButton;
        private var _modelMC:MovieClip;
        private var _model:int = 2;
        private var dl:DropList;
        private var _mail:Sprite;
        private var _soundTable:SoundTabelView;
        private var _screenShieldView:ScreenShieldView;
        private var _gameMc:BaseButton;
        private var _topPanelBtn:BaseButton;
        private var _screenShieldGuide:Sprite;
        private var _vmcShieldEffect:VMCView;
        private var _vmcEyeEffect:VMCView;
        private var _downTimeLine:int = 0;
        private var isHiteMemoryOut:Boolean = true;
        private var _saveDeskTxt:TextField;

        public function MiniMap()
        {
            loadDisplay("res/minimap.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("minimap");
            this.initUI();
            super.displayReady();
            this.freshInfo();
            return;
        }// end function

        private function initUI() : void
        {
            this._mapNameTxt = getDisplayChildByName("txt_mapname");
            this._posTxt = getDisplayChildByName("txt_pos");
            this._mapBtn = new BaseButton(getDisplayChildByName("btn_map"));
            this._lineBtn = new BaseButton(getDisplayChildByName("mc_line"));
            this._mapBtn.addEvtListener(MouseEvent.CLICK, this.__mapClick);
            this._lineBtn.addEvtListener(MouseEvent.CLICK, this.__lineClick);
            this.dl = new DropList(this._lineBtn, 900, 500);
            this.dl.cellRenderer = LineDropItem;
            this.dl.suspend = true;
            this.dl.listX = -1;
            var _loc_1:* = new RoleInfo();
            ItemTips.create(this._mapBtn, _loc_1, PersonTips);
            this._mail = getDisplayChildByName("mail");
            this._mailMc = new BaseButton(this._mail.getChildByName("mc_mail"), true);
            this._eyeMc = new BaseButton(getDisplayChildByName("mc_eye"), true);
            this._eyeMc.mouseChildren = true;
            this._eyeMc.addEventListener(MouseEvent.ROLL_OVER, this.rollOverEyeMc);
            this._eyeMc.addEventListener(MouseEvent.ROLL_OUT, this.rollOutEyeMc);
            this._screenShieldView = new ScreenShieldView();
            this._screenShieldView.setBtnCenterBus(this._eyeMc);
            this._screenShieldView.move(5, 30);
            this._mailCount = this._mail.getChildByName("mc_mailNum") as Sprite;
            this._mailCount.mouseEnabled = false;
            this._mailCount.mouseChildren = false;
            this._setMc = new BaseButton(getDisplayChildByName("mc_set"));
            this._soundMc = new BaseButton(getDisplayChildByName("mc_sound"), true);
            this._soundTable = new SoundTabelView();
            this._soundTable.move(5, 30);
            this._soundMc.mouseChildren = true;
            this._soundMc.addEvtListener(MouseEvent.ROLL_OVER, this._showSoundTable);
            this._soundMc.addEvtListener(MouseEvent.ROLL_OUT, this._hideSoundTable);
            var _loc_2:* = SoundControl.getInstance().currentPlayType;
            if (_loc_2 == SoundType.PLAYALL)
            {
                this._soundMc.selected = false;
            }
            else
            {
                this._soundMc.selected = true;
            }
            this._soundTable.setSeleted(_loc_2);
            this._soundTable.setRelativeBtn(this._soundMc);
            this._gameMc = new BaseButton(getDisplayChildByName("mc_game"));
            this._saveDeskTxt = getDisplayChildByName("txt_savedesk");
            this._saveDeskTxt.parent.removeChild(this._saveDeskTxt);
            this._GMTxt = getDisplayChildByName("txt_GM");
            this._forumTxt = getDisplayChildByName("txt_forum");
            this._officalWebTxt = getDisplayChildByName("txt_officalWeb");
            this._screenShieldGuide = Sprite(getDisplayChildByName("screen_shield_guide"));
            this._screenShieldGuide.mouseChildren = false;
            this._screenShieldGuide.visible = false;
            this._modelMC = getDisplayChildByName("btn_model");
            if (this._modelMC.parent)
            {
                this._modelMC.parent.removeChild(this._modelMC);
            }
            this._topPanelBtn = new BaseButton(getDisplayChildByName("topPanelBtn"));
            StringTip.create(this._modelMC, LanguageCfgObj.getInstance().getByIndex("10941"));
            this.updateView();
            this.addListener();
            var _loc_3:* = RoleList.getInstance().player;
            if (_loc_3)
            {
                this.setCoo(_loc_3.px, _loc_3.py);
            }
            StringTip.create(this._mail, LanguageCfgObj.getInstance().getByIndex("10942"));
            StringTip.create(this.dl, LanguageCfgObj.getInstance().getByIndex("10943"));
            StringTip.create(this._gameMc, LanguageCfgObj.getInstance().getByIndex("10944"));
            StringTip.create(this._topPanelBtn, LanguageCfgObj.getInstance().getByIndex("10945"));
            return;
        }// end function

        private function _showSoundTable(event:MouseEvent) : void
        {
            this._soundMc.addChild(this._soundTable);
            ToolKit.bringToTop(this);
            return;
        }// end function

        private function _hideSoundTable(event:MouseEvent) : void
        {
            if (this._soundTable && this._soundTable.parent)
            {
                this._soundMc.removeChild(this._soundTable);
            }
            return;
        }// end function

        private function rollOverEyeMc(event:MouseEvent) : void
        {
            this._eyeMc.addChild(this._screenShieldView);
            ToolKit.bringToTop(this);
            return;
        }// end function

        private function rollOutEyeMc(event:MouseEvent) : void
        {
            if (this._screenShieldView && this._screenShieldView.parent)
            {
                this._screenShieldView.parent.removeChild(this._screenShieldView);
            }
            return;
        }// end function

        private function updateView() : void
        {
            this.setCurrentLine(UserObj.getInstance().line);
            var _loc_1:* = MailController.getInstance().newMail;
            if (_loc_1 > 0)
            {
                _loc_1 = _loc_1 > 99 ? (99) : (_loc_1);
                (this._mailCount.getChildByName("txt") as TextField).text = _loc_1.toString();
                this._mailCount.visible = true;
            }
            else
            {
                this._mailCount.visible = false;
            }
            this._saveDeskTxt.htmlText = "<a href =\"event:saveDesk\"><font color = \'#f6ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12101") + "</font></a>";
            this._officalWebTxt.htmlText = "<a href =\"event:myEvent\">" + LanguageCfgObj.getInstance().getByIndex("12102") + "</a>";
            this._GMTxt.text = "";
            this._forumTxt.htmlText = "<a href =\"event:openSet\">" + LanguageCfgObj.getInstance().getByIndex("12103") + "</a>";
            MapControl.getInstance().reqLines();
            return;
        }// end function

        private function setCurrentLine(param1:int) : void
        {
            this._lineBtn.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12104"), [param1]));
            return;
        }// end function

        private function addListener() : void
        {
            addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._officalWebTxt.addEventListener(TextEvent.LINK, this.__link);
            this._GMTxt.addEventListener(TextEvent.LINK, this.__link);
            this._forumTxt.addEventListener(TextEvent.LINK, this.__link);
            this._saveDeskTxt.addEventListener(TextEvent.LINK, this.__link);
            this.dl.addEventListener(Event.CHANGE, this.__changeLine);
            FrameworkGlobal.addMsgListen(WndCloseEvt.CLOSE, this.__wndClose);
            FrameworkGlobal.addMsgsListen(["top_panel_show", "top_panel_hide"], this.__showOrHideToppanelBtn);
            FrameworkGlobal.addMsgListen(GameEvent.HIDE_OTHER_PLAYERS, this.hideOtherPlayer);
            this._screenShieldGuide.addEventListener(MouseEvent.CLICK, this.clickScreenShieldGuide);
            this._GMTxt.addEventListener(MouseEvent.ROLL_OVER, this.__over);
            this._officalWebTxt.addEventListener(MouseEvent.ROLL_OVER, this.__over);
            this._saveDeskTxt.addEventListener(MouseEvent.ROLL_OVER, this.__over);
            this._forumTxt.addEventListener(MouseEvent.ROLL_OVER, this.__over);
            this._forumTxt.addEventListener(MouseEvent.ROLL_OUT, this.__out);
            this._saveDeskTxt.addEventListener(MouseEvent.ROLL_OUT, this.__out);
            this._officalWebTxt.addEventListener(MouseEvent.ROLL_OUT, this.__out);
            this._GMTxt.addEventListener(MouseEvent.ROLL_OUT, this.__out);
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._officalWebTxt:
                {
                    this._officalWebTxt.htmlText = "<font color = \'#ffffff\'><a href =\"event:myEvent\">" + LanguageCfgObj.getInstance().getByIndex("12102") + "</a></font>";
                    break;
                }
                case this._GMTxt:
                {
                    this._GMTxt.text = "";
                    break;
                }
                case this._saveDeskTxt:
                {
                    this._saveDeskTxt.htmlText = "<a href =\"event:saveDesk\"><font color = \'#f6ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12101") + "</font></a>";
                    break;
                }
                case this._forumTxt:
                {
                    this._forumTxt.htmlText = "<font color = \'#ffffff\'><a href =\"event:openSet\">" + LanguageCfgObj.getInstance().getByIndex("12103") + "</a></font>";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._officalWebTxt:
                {
                    this._officalWebTxt.htmlText = "<font color = \'#1eff00\'><a href =\"event:myEvent\">" + LanguageCfgObj.getInstance().getByIndex("12102") + "</a></font>";
                    break;
                }
                case this._GMTxt:
                {
                    this._GMTxt.text = "";
                    break;
                }
                case this._saveDeskTxt:
                {
                    this._saveDeskTxt.htmlText = "<font color = \'#1eff00\'><a href =\"event:saveDesk\">" + LanguageCfgObj.getInstance().getByIndex("12101") + "</a></font>";
                    break;
                }
                case this._forumTxt:
                {
                    this._forumTxt.htmlText = "<font color = \'#1eff00\'><a href =\"event:openSet\">" + LanguageCfgObj.getInstance().getByIndex("12103") + "</a></font>";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __wndClose(param1:WndCloseEvt) : void
        {
            switch(param1.wnd)
            {
                case "com.game.mail.view::MailPanel":
                {
                    this._mailMc.selected = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __showOrHideToppanelBtn(event:Event) : void
        {
            switch(event.type)
            {
                case "top_panel_show":
                {
                    this.chageTopPanelBtnState(true);
                    break;
                }
                case "top_panel_hide":
                {
                    this.chageTopPanelBtnState(false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function chageTopPanelBtnState(param1:Boolean) : void
        {
            if (param1)
            {
                this._topPanelBtn.scaleX = 1;
                StringTip.create(this._topPanelBtn, LanguageCfgObj.getInstance().getByIndex("10945"));
            }
            else
            {
                this._topPanelBtn.scaleX = -1;
                StringTip.create(this._topPanelBtn, LanguageCfgObj.getInstance().getByIndex("10947"));
            }
            return;
        }// end function

        private function __changeLine(event:Event) : void
        {
            var _loc_2:* = null;
            if (event.target.selectObj)
            {
                if (this._downTimeLine <= 0)
                {
                    _loc_2 = event.target.selectObj.label;
                    MapControl.getInstance().selectLine(int(_loc_2.slice(0, _loc_2.indexOf(LanguageCfgObj.getInstance().getByIndex("10948")))));
                    this._downTimeLine = GlobalCfgObj.getInstance().getChangeLineCd();
                    Ticker.registerTimer(1, this.canChange);
                }
                else
                {
                    Global.popManager.addedToSystem(this._downTimeLine + LanguageCfgObj.getInstance().getByIndex("cdtext", "lang_minmap"));
                }
            }
            return;
        }// end function

        private function canChange() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._downTimeLine - 1;
            _loc_1._downTimeLine = _loc_2;
            if (this._downTimeLine <= 0)
            {
                Ticker.killTimer(this.canChange);
            }
            return;
        }// end function

        public function updateDropListLines(param1:Array, param2:int) : void
        {
            if (!this._lineBtn)
            {
                return;
            }
            this._lineBtn.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12104"), [UserObj.getInstance().line]));
            var _loc_3:* = MapCfgObj.getInstance().getMapLineControl(MapObj.getInstance().mapID, param2);
            var _loc_4:* = param1.length;
            if (_loc_3 == -1 || _loc_3 > _loc_4)
            {
                _loc_3 = _loc_4;
            }
            var _loc_5:* = new Array();
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3)
            {
                
                _loc_5.push({label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12104"), [param1[_loc_6].line])});
                _loc_6++;
            }
            this.dl.objs = _loc_5;
            return;
        }// end function

        public function setMailCount(param1:int) : void
        {
            if (this._mailCount == null)
            {
                return;
            }
            if (param1 > 0)
            {
                (this._mailCount.getChildByName("txt") as TextField).text = param1 > 99 ? ("99") : (param1.toString());
                this._mailCount.visible = true;
            }
            else
            {
                this._mailCount.visible = false;
            }
            return;
        }// end function

        private function __link(event:TextEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = null;
            switch(event.text)
            {
                case "saveDesk":
                {
                    DesktopControl.getInsatnce().saveDeskTopLink();
                    break;
                }
                case "myEvent":
                {
                    JSTools.openWindow(Params.officialWebSite);
                    break;
                }
                case "openSet":
                {
                    SettingsBox.getInstance().openOrClose();
                    break;
                }
                case "openLog":
                {
                    _loc_2 = new FileReference();
                    _loc_3 = new ByteArray();
                    _loc_3.writeMultiByte(Log.strAll, "utf-8");
                    _loc_4 = new Date();
                    _loc_5 = _loc_4.getHours();
                    _loc_6 = _loc_4.getMinutes();
                    _loc_7 = _loc_4.getSeconds();
                    _loc_8 = _loc_5 + "点" + _loc_6 + "分" + _loc_7 + "秒";
                    _loc_2.save(Log.strAll, BasicGlobal.openid + "Log" + _loc_8 + ".txt");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            ToolKit.bringToTop(this);
            switch(event.target)
            {
                case this._setMc:
                {
                    SettingsBox.getInstance().openOrClose();
                    break;
                }
                case this._mailMc:
                {
                    MailController.getInstance().openMail();
                    break;
                }
                case this._soundMc:
                {
                    if (this._soundMc.selected)
                    {
                        SoundControl.getInstance().setting(2);
                        this._soundTable.setSeleted(2);
                    }
                    else
                    {
                        SoundControl.getInstance().setting(1);
                        this._soundTable.setSeleted(1);
                    }
                    break;
                }
                case this._eyeMc:
                {
                    this.clickeyeMc();
                    break;
                }
                case this._gameMc:
                {
                    GameStrategyControl.getInstance().openOrCloseStrategyBox();
                    break;
                }
                case this._topPanelBtn:
                {
                    _loc_2 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                    if (!ZonesControl.getInstance().inBossHome() && _loc_2.zones_type > 0)
                    {
                        return;
                    }
                    if (this._topPanelBtn.scaleX == 1)
                    {
                        this.chageTopPanelBtnState(false);
                        MapControl.getInstance().openOrCloseTopPanel(false);
                    }
                    else
                    {
                        MapControl.getInstance().openOrCloseTopPanel(true);
                        this.chageTopPanelBtnState(true);
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

        private function clickScreenShieldGuide(event:MouseEvent) : void
        {
            this.isHiteMemoryOut = false;
            if (this._screenShieldGuide && this._screenShieldGuide.parent)
            {
                this._screenShieldGuide.visible = false;
                if (this._vmcEyeEffect)
                {
                    this._vmcEyeEffect.stop();
                    this._vmcEyeEffect.parent.removeChild(this._vmcEyeEffect);
                    this._vmcEyeEffect.finalize();
                }
                if (this._vmcShieldEffect)
                {
                    this._vmcShieldEffect.stop();
                    this._vmcShieldEffect.parent.removeChild(this._vmcShieldEffect);
                    this._vmcShieldEffect.finalize();
                }
                this._screenShieldGuide.parent.removeChild(this._screenShieldGuide);
            }
            return;
        }// end function

        private function clickeyeMc() : void
        {
            this.clickScreenShieldGuide(null);
            this.showOrHidePlayer(this._eyeMc.selected);
            return;
        }// end function

        private function hideOtherPlayer(event:GameEvent) : void
        {
            var _loc_3:* = false;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2 && _loc_2.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                _loc_3 = true;
            }
            if (UICfg.hideOtherPlayer != true && !_loc_3)
            {
                if (this.isHiteMemoryOut)
                {
                    if (this._screenShieldView && !this._screenShieldView.getSelectAllState())
                    {
                        FrameworkGlobal.stage.addChild(this._screenShieldGuide);
                        this._screenShieldGuide.visible = true;
                        if (!this._vmcShieldEffect)
                        {
                            this._vmcShieldEffect = new VMCView();
                            this._vmcShieldEffect.auto = true;
                            this._vmcShieldEffect.loadRes("res/effect/screenshield/shieldeffect.png", null, true);
                            this._vmcShieldEffect.updatePose("90", true);
                            this._vmcShieldEffect.move(100, 5);
                            this._screenShieldGuide.addChild(this._vmcShieldEffect);
                        }
                        if (!this._vmcEyeEffect)
                        {
                            this._vmcEyeEffect = new VMCView();
                            this._vmcEyeEffect.auto = true;
                            this._vmcEyeEffect.loadRes("res/effect/screenshield/eyeeffect.png", null, true);
                            this._vmcEyeEffect.updatePose("90", true);
                            this._eyeMc.addChild(this._vmcEyeEffect);
                            this._vmcEyeEffect.move(15, 17);
                        }
                        this.resize();
                    }
                }
                return;
            }
            return;
        }// end function

        public function getScreenShiledSelectState() : Boolean
        {
            if (this._screenShieldView)
            {
                return this._screenShieldView.getSelectAllState();
            }
            return false;
        }// end function

        override public function resize() : void
        {
            super.resize();
            if (this._screenShieldGuide && this._screenShieldGuide.parent)
            {
                this._screenShieldGuide.x = FrameworkGlobal.stageW - 206;
                this._screenShieldGuide.y = 166;
            }
            return;
        }// end function

        public function showOrHidePlayer(param1:Boolean) : void
        {
            if (this._eyeMc.selected != param1)
            {
                this._eyeMc.selected = param1;
            }
            UICfg.hideOtherPlayer = param1;
            VMCManager.checkAndGC(true);
            return;
        }// end function

        public function setAwaitFunction() : void
        {
            if (this._screenShieldView)
            {
                this._screenShieldView.setAwaitFunction();
            }
            return;
        }// end function

        private function __lineClick(event:MouseEvent) : void
        {
            ToolKit.bringToTop(this);
            return;
        }// end function

        private function setModel(event:Event) : void
        {
            switch(event.type)
            {
                case "showShadow":
                {
                    this._model = 3;
                    this._modelMC.gotoAndStop(1);
                    break;
                }
                case "hideShadow":
                {
                    this._model = 2;
                    this._modelMC.gotoAndStop(2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __modelClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._modelMC:
                {
                    if (this._model == 3)
                    {
                        this._model = 2;
                        FrameworkGlobal.sendMsg(new Event("hideShadow"));
                        FrameworkGlobal.showHighLevelShadow = false;
                        this._modelMC.gotoAndStop(2);
                    }
                    else if (this._model == 2)
                    {
                        this._model = 3;
                        FrameworkGlobal.sendMsg(new Event("showShadow"));
                        FrameworkGlobal.showHighLevelShadow = true;
                        this._modelMC.gotoAndStop(1);
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

        private function __mapClick(event:MouseEvent) : void
        {
            MapControl.getInstance().openBigMapPanel();
            return;
        }// end function

        public function setCoo(param1:int, param2:int) : void
        {
            if (this._posTxt)
            {
                this._posTxt.htmlText = "(" + param1 + "," + param2 + ")";
            }
            return;
        }// end function

        private function __updateLevel(event:RoleEvent) : void
        {
            var _loc_2:* = event.currentTarget as RoleInfo;
            return;
        }// end function

        public function freshInfo() : void
        {
            var _loc_1:* = null;
            if (UILoaded)
            {
                _loc_1 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                if (_loc_1.mapName)
                {
                    this._mapNameTxt.text = _loc_1.mapName;
                }
                this.setCurrentLine(UserObj.getInstance().line);
            }
            return;
        }// end function

        public function flashToEmail(param1:Array, param2:Point) : void
        {
            var _loc_3:* = param1.length;
            if (_loc_3 <= 1)
            {
                return;
            }
            if (param1[0] is int)
            {
                ItemGetAnim.doFlyGetItemsTo(param1, this._mailMc.localToGlobal(new Point(0, 0)), param2);
            }
            return;
        }// end function

    }
}
