package com.game.operationpanel.view
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.buff.view.*;
    import com.game.operationpanel.control.*;
    import com.game.shop.control.*;
    import com.game.vip.control.*;
    import com.game.vip.model.*;
    import com.game.worldlevel.event.*;
    import com.game.worldlevel.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.utils.*;

    public class BuffContainer extends HBox
    {
        private var _info:PlayerInfo;
        private var buffIcons:Dictionary;
        private const LOGI_NBUFF_ID:uint;
        private const LK_BUFF_ID:uint;
        private const WORLD_LEVEL_BUFF_ID:uint;

        public function BuffContainer()
        {
            this.LOGI_NBUFF_ID = GlobalCfgObj.getInstance().getPlatbuffId();
            this.LK_BUFF_ID = GlobalCfgObj.getInstance().getPkRedBuff();
            this.WORLD_LEVEL_BUFF_ID = GlobalCfgObj.getInstance().getWorldLevelBuff();
            horizontal = true;
            intervalX = 3;
            intervalY = 5;
            oneRow = 7;
            this.init();
            this.addEvent();
            addEventListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        private function addEvent() : void
        {
            this._info.addEvtListener(RoleEvent.UPDATE_BUFF, this.__updateBuff);
            this._info.addEvtListener(RoleEvent.UPDATE_PK_VALUE, this.__updateOrdeletePKBuff);
            this._info.dispatchEvt(new RoleEvent(RoleEvent.UPDATE_PK_VALUE));
            WorldLevelData.getInstance().addEventListener(WorldLevelEvent.WORLD_LEVEL_DATA_CHANGE, this.__updateWorldLevelBuff);
            this.__updateWorldLevelBuff();
            return;
        }// end function

        private function init() : void
        {
            this._info = UserObj.getInstance().playerInfo;
            this.buffIcons = new Dictionary();
            if (Params.wdType != WeiDuanType.NO_WEIDUAN)
            {
                this.updateLoginBuff(Params.loginType == LoginType.WEIDUAN);
            }
            this.updateVipBuff();
            return;
        }// end function

        private function __updateBuff(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.buffIcons == null)
            {
                this.buffIcons = new Dictionary();
            }
            if (event.obj.op && event.obj.op == "AU")
            {
                _loc_2 = event.obj.t;
                _loc_4 = this.getBuffInfo(_loc_2);
                if (!_loc_4 || !_loc_4.q_ico || _loc_4.q_ico == "")
                {
                    return;
                }
                if (!this.buffIcons[_loc_2])
                {
                    this.buffIcons[_loc_2] = new BuffIcon();
                }
                _loc_3 = this.buffIcons[_loc_2];
                _loc_3.setInfo(_loc_4);
                this.buffIcons[_loc_2] = _loc_3;
                add(_loc_3);
            }
            else if (event.obj.op && event.obj.op == "D")
            {
                _loc_2 = event.obj.t;
                _loc_3 = this.buffIcons[_loc_2];
                _loc_4 = this.getBuffInfo(_loc_2);
                if (_loc_4 && _loc_3)
                {
                    _loc_3.setTxt(_loc_4.num);
                }
                else
                {
                    if (_loc_3)
                    {
                        remove(_loc_3);
                        _loc_3.finalize();
                    }
                    this.buffIcons[_loc_2] = null;
                    delete this.buffIcons[_loc_2];
                }
            }
            if (_loc_3 && _loc_4 && _loc_4.num > 1)
            {
                _loc_3.setTxt(_loc_4.num);
            }
            return;
        }// end function

        private function getBuffInfo(param1:uint) : BuffInfo
        {
            var _loc_3:* = null;
            var _loc_2:* = this._info.buffs;
            var _loc_4:* = _loc_2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                if ((_loc_2[_loc_5] as BuffInfo).q_buff_id == param1)
                {
                    return _loc_2[_loc_5];
                }
                _loc_5++;
            }
            return null;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.buffIcons[this.LOGI_NBUFF_ID]:
                {
                    if (Params.loginType != LoginType.WEIDUAN)
                    {
                        OperationPanelControl.getInstance().openWeiDuanPanel();
                    }
                    break;
                }
                case this.buffIcons[Params.VIP_BUFFID]:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case this.buffIcons[this.LK_BUFF_ID]:
                {
                    _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(700049);
                    ShopController.getInstance().openBuyItem(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __updateOrdeletePKBuff(event:RoleEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.target as RoleInfo;
            var _loc_4:* = BuffCfgObj.getInstance().getBuffInfo(this.LK_BUFF_ID);
            _loc_4.value = _loc_2.pkValue;
            _loc_3 = this.buffIcons[this.LK_BUFF_ID];
            if (_loc_4.value > 0)
            {
                if (_loc_3 == null)
                {
                    var _loc_5:* = new BuffIcon();
                    this.buffIcons[this.LK_BUFF_ID] = new BuffIcon();
                    _loc_3 = _loc_5;
                    add(_loc_3);
                }
                _loc_3.setInfo(_loc_4);
            }
            else
            {
                remove(_loc_3);
                this.buffIcons[this.LK_BUFF_ID] = null;
                delete this.buffIcons[this.LK_BUFF_ID];
            }
            return;
        }// end function

        private function __updateWorldLevelBuff(event:Event = null) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_2:* = WorldLevelData.getInstance();
            var _loc_4:* = BuffCfgObj.getInstance().getBuffInfo(this.WORLD_LEVEL_BUFF_ID);
            _loc_3 = this.buffIcons[this.WORLD_LEVEL_BUFF_ID];
            if (_loc_2.isWorldLevelEnabled())
            {
                if (_loc_3 == null)
                {
                    var _loc_6:* = new BuffIcon();
                    this.buffIcons[this.WORLD_LEVEL_BUFF_ID] = new BuffIcon();
                    _loc_3 = _loc_6;
                    add(_loc_3);
                }
                _loc_5 = "<font color = \'#ffee5a\'>" + LanguageCfgObj.getInstance().getByIndex("12119") + "</font><br/>" + "<font color =\'#ffffff\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12120"), [_loc_2.worldLevel]);
                if (_loc_2.isAdditionActive())
                {
                    _loc_5 = _loc_5 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12121"), [_loc_2.getLevelDif()]) + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12122"), [_loc_2.getExpAddition()]));
                }
                else if (_loc_2.playerLevel >= _loc_2.worldLevel)
                {
                    _loc_5 = _loc_5 + (LanguageCfgObj.getInstance().getByIndex("12123") + "<br/>" + LanguageCfgObj.getInstance().getByIndex("10975"));
                }
                else
                {
                    _loc_5 = _loc_5 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12124"), [WorldLevelConst.worldLevelEnableMinPlayerLevelDif]) + LanguageCfgObj.getInstance().getByIndex("10975"));
                }
                _loc_5 = _loc_5 + "</font>";
                _loc_4.q_buff_name = _loc_5;
                _loc_3.setInfo(_loc_4, _loc_2.isAdditionActive());
            }
            else if (_loc_3 != null)
            {
                remove(_loc_3);
                delete this.buffIcons[this.WORLD_LEVEL_BUFF_ID];
            }
            return;
        }// end function

        public function updateVipBuff() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (VipModel.getInstance().info == null)
            {
                return;
            }
            if (this.buffIcons == null)
            {
                this.buffIcons = new Dictionary();
            }
            if (this.buffIcons[Params.VIP_BUFFID] == null)
            {
                this.buffIcons[Params.VIP_BUFFID] = new BuffIcon();
            }
            _loc_1 = this.buffIcons[Params.VIP_BUFFID];
            _loc_2 = new BuffInfo();
            _loc_2.q_buff_id = Params.VIP_BUFFID;
            var _loc_3:* = VipModel.getInstance().info.level >= VipModel.BUFF_ACTIVITE_LEVEL ? (VipModel.getInstance().info.level) : (4);
            var _loc_4:* = "<font color = \'#ffee5a\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12125"), [_loc_3]) + "</font><br>";
            var _loc_5:* = false;
            if (VipModel.getInstance().info.level >= VipModel.BUFF_ACTIVITE_LEVEL)
            {
                _loc_4 = _loc_4 + "{remain}<br>";
                _loc_5 = true;
            }
            else
            {
                _loc_4 = _loc_4 + LanguageCfgObj.getInstance().getByIndex("12127");
            }
            _loc_2.q_buff_name = "<font color=\'#FFF000\'>" + _loc_4 + VIPShowCfgObj.getInstance().getVipTips(_loc_3) + "</font>\n";
            _loc_2.icon = Params.BUFF_ICON_PATH + "i40011.png";
            if (VipModel.getInstance().info.level >= VipModel.BUFF_ACTIVITE_LEVEL)
            {
                _loc_2.remain = VipModel.getInstance().getCount();
                _loc_1.setInfo(_loc_2, _loc_5, true);
            }
            else
            {
                _loc_1.setInfo(_loc_2, _loc_5, false);
            }
            this.buffIcons[Params.VIP_BUFFID] = _loc_1;
            add(_loc_1);
            return;
        }// end function

        private function updateLoginBuff(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = BuffCfgObj.getInstance().getBuffInfo(this.LOGI_NBUFF_ID);
            if (this.buffIcons[this.LOGI_NBUFF_ID] == null)
            {
                this.buffIcons[this.LOGI_NBUFF_ID] = new BuffIcon();
            }
            _loc_2 = this.buffIcons[this.LOGI_NBUFF_ID];
            if (!param1)
            {
                _loc_3.q_buff_name = LanguageCfgObj.getInstance().getByIndex("10977");
                _loc_3.q_buff_name = _loc_3.q_buff_name + LanguageCfgObj.getInstance().getByIndex("12128");
                _loc_3.q_buff_name = _loc_3.q_buff_name + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12130"), [Params.GAME_NAME]);
                _loc_2.setInfo(_loc_3, false);
            }
            else
            {
                _loc_3.q_buff_name = LanguageCfgObj.getInstance().getByIndex("10977");
                _loc_3.q_buff_name = _loc_3.q_buff_name + ("<font color =\'#fff600\'>" + LanguageCfgObj.getInstance().getByIndex("12129") + "<br/>");
                _loc_3.q_buff_name = _loc_3.q_buff_name + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12130"), [Params.GAME_NAME]);
                _loc_2.setInfo(_loc_3, true);
            }
            this.buffIcons[this.LOGI_NBUFF_ID] = _loc_2;
            add(_loc_2);
            return;
        }// end function

    }
}
