package com.game.zones.view.wolfsoul
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.vip.consts.*;
    import com.game.zones.control.*;
    import com.game.zones.view.base.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class ZonesWolfSoulPanel extends ZonesBasePanel
    {
        private static var HIT_CLEARCD:String = LanguageCfgObj.getInstance().getByIndex("11453");

        public function ZonesWolfSoulPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override public function open() : void
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            super.open();
            this._zoneTableInfo = ZonesCloneCfg.getInstance().getCurZones(_loc_1, 3);
            if (this._zoneTableInfo)
            {
                ZonesControl.getInstance().reqZoneTeamOpenToGame(this._zoneTableInfo.id);
            }
            if (UILoaded)
            {
                _propaganda.gotoAndStop(3);
            }
            return;
        }// end function

        override protected function initUI() : void
        {
            super.initUI();
            _propaganda.gotoAndStop(3);
            _txtTile.gotoAndStop(3);
            _txtZonesCDtitle.visible = false;
            _txtZonesCD.visible = false;
            _btnClean.visible = false;
            _txtCleanBtn.visible = false;
            _txtZoneLevel.visible = false;
            _txtZoneRule.visible = false;
            _enterItemTxt.visible = false;
            _enterItemImg.visible = false;
            var _loc_1:* = false;
            _txtFightImg.visible = false;
            _txtFightTitle.visible = _loc_1;
            _txtFight.visible = _loc_1;
            var _loc_1:* = _txtAwardImg.y - 11;
            _txtAwardImg.y = _txtAwardImg.y - 11;
            _txtAwardTitle.y = _loc_1;
            _txtAward.y = _loc_1;
            _txtCountTitle.x = _txtZonesCDtitle.x;
            _txtCount.x = _txtCountTitle.x + _txtCountTitle.width;
            _vipTxt.x = 179;
            return;
        }// end function

        override protected function cleanZonesCD() : void
        {
            super.cleanZonesCD();
            var _loc_1:* = this._cdEnter.count / 1000;
            if (_loc_1 <= 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11526"));
                return;
            }
            var _loc_2:* = Math.floor(this._cdEnter.count / (1000 * 30));
            var _loc_3:* = HIT_CLEARCD.replace("#", _loc_2.toString());
            Global.popManager.cue(_loc_3, "", null, this.callCleanCD);
            return;
        }// end function

        override protected function getNestUpVip() : int
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.vipid;
            var _loc_2:* = VipCfgObj.getInstance().wolfSoulAdd(_loc_1);
            var _loc_3:* = _loc_1 + 1;
            while (_loc_3 <= VipConst.VIP_MAX_LEVEL)
            {
                
                if (VipCfgObj.getInstance().wolfSoulAdd(_loc_3) > _loc_2)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        override protected function setBaseInfo() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (UILoaded && _zoneServerInfo)
            {
                this._txtCount.text = (zoneServerInfo.enterMaxnum - zoneServerInfo.enternum).toString();
                if (this._zoneTableInfo)
                {
                    _loc_2 = TIPS_WORD;
                    _loc_3 = this.getNestUpVip();
                    _loc_4 = VipCfgObj.getInstance().wolfSoulAdd(_loc_3);
                    _loc_2 = _loc_2.replace("X1", _loc_3.toString());
                    _loc_2 = _loc_2.replace("X2", _zoneTableInfo.duplicate_name);
                    _loc_2 = _loc_2.replace("X3", _loc_4.toString());
                    StringTip.create(this._vipTxt, _loc_2);
                    _loc_5 = this._zoneTableInfo.need_item;
                    if (this._zoneTableInfo.need_item && this._zoneTableInfo.need_item != "" && this._zoneTableInfo.need_item != "0")
                    {
                        _loc_6 = _loc_5.split(";");
                        _loc_7 = PropUtil.createItemByCfg(int(_loc_6[0]));
                        _loc_7.num = int(_loc_6[1]);
                        if (!this._toolIcon.parent)
                        {
                            this.addChild(this._toolIcon);
                        }
                        this._toolIcon.setImageSize(40, 40);
                        this._toolIcon.setInfo(_loc_7);
                    }
                }
                _loc_1 = int(_zoneServerInfo.wait_time.toNumber() - (ToolKit.getServerTime() - _zoneServerInfo.last_time.toNumber()));
                if (_loc_1 > 0 && _zoneServerInfo.isopen == 3)
                {
                    this._cdEnter.count = _loc_1;
                    _isCD = true;
                    this._btnEnter.filters = [ColorFilter.getGrayFilter()];
                    this._btnEnter.mouseEnabled = false;
                    this._btnTeamEnter.filters = [ColorFilter.getGrayFilter()];
                    this._btnTeamEnter.mouseEnabled = false;
                    this._btnClean.visible = true;
                    this._txtCleanBtn.visible = true;
                }
                else
                {
                    this._cdEnter.count = 0;
                    this._btnClean.visible = false;
                    this._txtCleanBtn.visible = false;
                }
            }
            return;
        }// end function

        override protected function enterZones() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (_isCD)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11527"));
                return;
            }
            if (this._zoneTableInfo)
            {
                _loc_1 = this._zoneTableInfo.need_item;
                _loc_2 = _loc_1.split(";");
                BackPackControl.getInstance().checkItemenough(_loc_2[0], _loc_2[1], this.showEnterCue);
            }
            return;
        }// end function

        private function showEnterCue() : void
        {
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12350"), LanguageCfgObj.getInstance().getByIndex("11635"), null, super.enterZones);
            return;
        }// end function

        private function callCleanCD() : void
        {
            ZonesControl.getInstance().reqclearZoneCD(this.zoneServerInfo.zoneid);
            return;
        }// end function

    }
}
