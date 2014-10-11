package com.game.challenge.view.component
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.challenge.bean.*;
    import com.game.challenge.control.*;
    import com.game.challenge.model.*;
    import com.game.map.control.*;
    import com.game.task.*;
    import com.game.utils.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import interfaces.role.*;

    public class BossItem extends Component
    {
        public var remainTime:Number;
        private var _goToBtnMc:MovieClip;
        private var _bgMc:MovieClip;
        private var _shoesMc:BaseButton;
        private var _bossNameTxt:TextField;
        private var _timingTxt:TextField;
        private var _config:QMonsterBossQcfg;
        private var _qsceneMonsterAreaBean:QSceneMonsterAreaBean;
        private var _index:int;
        private var mc_notDrop:MovieClip;
        private var showTime:Boolean = true;
        private static var enableFilter:ColorMatrixFilter = new ColorMatrixFilter(ColorFilter.saturationPer(-90));

        public function BossItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            addEvtListener(MouseEvent.CLICK, this.__click);
            addEvtListener(MouseEvent.MOUSE_OVER, this.__focus);
            addEvtListener(MouseEvent.MOUSE_OUT, this.__cancelfocus);
            addEvtListener(Event.REMOVED_FROM_STAGE, this.__killTime);
            return;
        }// end function

        private function initUI() : void
        {
            this._goToBtnMc = getDisplayChildByName("goToBtnMc");
            this._goToBtnMc.stop();
            this._bgMc = getDisplayChildByName("bgMc");
            this._bgMc.stop();
            this.mc_notDrop = getDisplayChildByName("mc_notDrop");
            this.mc_notDrop.visible = false;
            this._shoesMc = new BaseButton(getDisplayChildByName("shoesMc"));
            this._bossNameTxt = getDisplayChildByName("bossNameTxt");
            this._timingTxt = getDisplayChildByName("timingTxt");
            return;
        }// end function

        public function setConfig(param1:int, param2:QMonsterBossQcfg) : void
        {
            this._index = param1;
            this._config = param2;
            this._qsceneMonsterAreaBean = QSceneMonsterAreaBeanCfgObj.getInstance().getMonsterByModelIdAndMapId(this._config.q_monsterid, this._config.q_map);
            this._goToBtnMc.gotoAndStop(param1);
            this._bgMc.gotoAndStop(param1);
            StringTip.create(this._shoesMc, StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12371"), MapCfgObj.getInstance().getMap(param2.q_map).mapName, GlobalCfgObj.getInstance().getBossVipLevel()));
            var _loc_3:* = MonsterCfgObj.getInstance().getMonsterObjCfg(this._config.q_monsterid);
            this._bossNameTxt.htmlText = "<font color = \'#ff9900\'>" + _loc_3.q_name + "[" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [_loc_3.q_grade]) + "]</font>";
            return;
        }// end function

        public function updateInfo(param1:BossInfo) : void
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            Ticker.killTimer(this.__updateTime);
            var _loc_2:* = param1.bossLogs[(this._index - 1)];
            if (!_loc_2)
            {
                _loc_3 = new Vector.<BossKillEventInfo>;
            }
            else
            {
                _loc_3 = (param1.bossLogs[(this._index - 1)] as BossKillInfo).events;
            }
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = "";
            if (_loc_4 == 0 || _loc_2.isDead == 0)
            {
                this.remainTime = 0;
            }
            else
            {
                this.remainTime = this._qsceneMonsterAreaBean.q_relive - (param1.serverTime - (_loc_3[(_loc_3.length - 1)] as BossKillEventInfo).touchTime.toNumber()) / 1000;
                Ticker.registerTimer(1, this.__updateTime);
            }
            if (this.remainTime <= 0)
            {
                this._timingTxt.text = LanguageCfgObj.getInstance().getByIndex("10437");
                this.enabled = true;
            }
            else
            {
                this._timingTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11948"), [Math.ceil(this.remainTime / 60)]);
                this.enabled = false;
            }
            var _loc_7:* = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_6 = _loc_3[_loc_7];
                _loc_5 = _loc_5 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11949"), [ToolKit.getTimeBySecond2(_loc_6.touchTime.toNumber() / 1000), _loc_6.playerName]) + "<br/>");
                _loc_7++;
            }
            ItemTips.create(this._bgMc, {config:this._config, frame:this._index, hitLog:_loc_5, freshtime:this._timingTxt}, BossItemTips);
            var _loc_8:* = UserObj.getInstance().playerInfo.level;
            var _loc_9:* = MonsterCfgObj.getInstance().getMonsterObjCfg(this._config.q_monsterid);
            var _loc_10:* = GlobalCfgObj.getInstance().getMousterLevel4();
            if (_loc_8 - _loc_9.q_grade > _loc_10)
            {
                this.mc_notDrop.visible = true;
            }
            else
            {
                this.mc_notDrop.visible = false;
            }
            return;
        }// end function

        private function __updateTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.remainTime - 1;
            _loc_1.remainTime = _loc_2;
            if (this.remainTime <= 0)
            {
                Ticker.killTimer(this.__updateTime);
                this._timingTxt.text = LanguageCfgObj.getInstance().getByIndex("10437");
                this.enabled = true;
            }
            else
            {
                this._timingTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11948"), [Math.ceil(this.remainTime / 60)]);
                this.enabled = false;
            }
            return;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            var _loc_2:* = null;
            _loc_2 = MonsterCfgObj.getInstance().getMonsterObjCfg(this._config.q_monsterid);
            if (param1)
            {
                this.filters = null;
                this._bossNameTxt.htmlText = "<font color = \'#ff9900\'>" + _loc_2.q_name + "[" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [_loc_2.q_grade]) + "]</font>";
                this._shoesMc.visible = true;
            }
            else
            {
                this._bossNameTxt.htmlText = "<font color = \'#00be12\'>" + _loc_2.q_name + "[" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [_loc_2.q_grade]) + "]</font>";
                this.filters = [enableFilter];
                this._shoesMc.visible = false;
            }
            return;
        }// end function

        private function __killTime(event:Event) : void
        {
            Ticker.killTimer(this.__updateTime);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this._goToBtnMc:
                case this._bgMc:
                {
                    _loc_2 = RoleList.getInstance().player;
                    TaskGlobal.manager.taskFindPath(this._config.q_map_x, this._config.q_map_y, this._config.q_map, true, 1);
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                case this._shoesMc:
                {
                    if (UserObj.getInstance().playerInfo.vipid >= GlobalCfgObj.getInstance().getBossVipLevel())
                    {
                        MapControl.getInstance().changeMapByPos(this._config.q_map, this._config.q_map_x, this._config.q_map_y, new long(), 1, 3);
                        BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    }
                    else
                    {
                        TaskGlobal.manager.taskFindPath(this._config.q_map_x, this._config.q_map_y, this._config.q_map, true, 1);
                        BossGuideControl.getInstance().openOrCloseBossGuildPanel();
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

        private function __focus(event:MouseEvent) : void
        {
            var _loc_2:* = new GlowFilter(16773120, 0.8, 10, 10, 1, 20);
            switch(event.target)
            {
                case this._goToBtnMc:
                case this._bgMc:
                case this._shoesMc:
                {
                    this._bgMc.filters = [_loc_2];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __cancelfocus(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._goToBtnMc:
                case this._bgMc:
                case this._shoesMc:
                {
                    this._bgMc.filters = null;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function finalize() : void
        {
            removeEvtListener(MouseEvent.CLICK, this.__click);
            removeEvtListener(MouseEvent.MOUSE_OVER, this.__focus);
            removeEvtListener(MouseEvent.MOUSE_OUT, this.__cancelfocus);
            super.finalize();
            return;
        }// end function

    }
}
