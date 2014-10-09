package com.view.tipcell
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;

    public class TaskAwardTips extends BaseTips
    {
        private var _backImg:Sprite;
        private var _content:Sprite;

        public function TaskAwardTips()
        {
            this._backImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backImg);
            this._content = new Sprite();
            addChild(this._content);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = null;
            var _loc_31:* = 0;
            var _loc_32:* = 0;
            var _loc_33:* = null;
            var _loc_34:* = 0;
            var _loc_35:* = 0;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = false;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = null;
            if (param1 is int)
            {
                _loc_2 = TaskCfgObj.getInstance().getDailyReward(int(param1));
            }
            else
            {
                _loc_2 = param1;
            }
            var _loc_3:* = this.getTextField(18, 11);
            if (param1 is int)
            {
                _loc_3.htmlText = LanguageCfgObj.getInstance().getByIndex("10167");
            }
            else
            {
                _loc_3.htmlText = "<font color=\'#FFB127\' size=\'14\'>" + _loc_2.q_name + "</font>";
            }
            this._content.addChild(_loc_3);
            var _loc_4:* = _loc_2.q_rewards_exp;
            var _loc_5:* = _loc_2.q_rewards_coin;
            var _loc_6:* = _loc_2.q_rewards_zq;
            var _loc_7:* = _loc_2.q_rewards_exploit;
            var _loc_8:* = _loc_2.q_rewards_prestige;
            var _loc_9:* = _loc_2.q_rewards_bindYuanBao;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (Number(_loc_4) > 0)
            {
                _loc_13 = this.getTextPoint(_loc_11);
                this._content.addChild(_loc_13);
                _loc_14 = this.getTextField(36, 61 + _loc_11 * 22);
                _loc_14.htmlText = "<font color=\'#FFFFFF\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_4 + "</font>";
                this._content.addChild(_loc_14);
                _loc_11++;
            }
            if (_loc_5 > 0)
            {
                _loc_15 = this.getTextPoint(_loc_11);
                this._content.addChild(_loc_15);
                _loc_16 = this.getTextField(36, 61 + _loc_11 * 22);
                _loc_16.htmlText = "<font color=\'#F6FF00\'>" + LanguageCfgObj.getInstance().getByIndex("11822") + _loc_5 + "</font>";
                this._content.addChild(_loc_16);
                _loc_11++;
            }
            if (_loc_6 > 0)
            {
                _loc_17 = this.getTextPoint(_loc_11);
                this._content.addChild(_loc_17);
                _loc_18 = this.getTextField(36, 61 + _loc_11 * 22);
                _loc_18.htmlText = "<font color=\'#45B1CE\'>" + LanguageCfgObj.getInstance().getByIndex("11823") + _loc_6 + "</font>";
                this._content.addChild(_loc_18);
                _loc_11++;
            }
            if (_loc_7 > 0)
            {
                _loc_19 = this.getTextPoint(_loc_11);
                this._content.addChild(_loc_19);
                _loc_20 = this.getTextField(36, 61 + _loc_11 * 22);
                _loc_20.htmlText = "<font color=\'#FFFFFF\'>" + LanguageCfgObj.getInstance().getByIndex("11824") + _loc_7 + "</font>";
                this._content.addChild(_loc_20);
                _loc_11++;
            }
            if (_loc_8 > 0)
            {
                _loc_21 = this.getTextPoint(_loc_11);
                this._content.addChild(_loc_21);
                _loc_22 = this.getTextField(36, 61 + _loc_11 * 22);
                _loc_22.htmlText = "<font color=\'#FFFFFF\'>" + LanguageCfgObj.getInstance().getByIndex("11825") + _loc_8 + "</font>";
                this._content.addChild(_loc_22);
                _loc_11++;
            }
            if (_loc_9 > 0)
            {
                _loc_23 = this.getTextPoint(_loc_11);
                this._content.addChild(_loc_23);
                _loc_24 = this.getTextField(36, 61 + _loc_11 * 22);
                _loc_24.htmlText = "<font color=\'#F6FF00\'>" + LanguageCfgObj.getInstance().getByIndex("11826") + _loc_9 + "</font>";
                this._content.addChild(_loc_24);
                _loc_11++;
            }
            var _loc_12:* = _loc_2.q_rewards_goods;
            if (_loc_2.q_rewards_goods != null && _loc_12 != "")
            {
                _loc_25 = _loc_12.split(";");
                _loc_26 = 0;
                while (_loc_26 < _loc_25.length)
                {
                    
                    _loc_27 = _loc_25[_loc_26];
                    _loc_28 = _loc_27.split("_");
                    _loc_29 = _loc_28.length;
                    _loc_30 = _loc_28[0];
                    if (_loc_30.indexOf("!") != -1)
                    {
                        _loc_31 = int(_loc_30.substr(1, (_loc_30.length - 1)));
                        _loc_32 = 1;
                    }
                    else
                    {
                        _loc_31 = int(_loc_30);
                        _loc_32 = 0;
                    }
                    _loc_33 = ItemCfgObj.getInstance().getCfgBy(_loc_31);
                    if (!_loc_33)
                    {
                    }
                    else
                    {
                        _loc_34 = _loc_28[1];
                        if (_loc_29 > 2)
                        {
                            _loc_39 = _loc_28[2].toString().charAt((UserObj.getInstance().playerInfo.job - 1)) == "1";
                            if (!_loc_39)
                            {
                                ;
                            }
                        }
                        if (_loc_29 > 3)
                        {
                            _loc_35 = _loc_28[3];
                        }
                        if (!PropUtil.isEquip(_loc_33.q_type))
                        {
                            _loc_40 = new PropInfo();
                            _loc_40.convByCfg(_loc_31);
                            _loc_40.isbind = _loc_32;
                            _loc_36 = PropUtil.getEquipNameAndColor(_loc_40);
                        }
                        else
                        {
                            _loc_41 = new EquipmentInfo();
                            _loc_41.convEquipByCfg(_loc_31, _loc_35);
                            _loc_36 = PropUtil.getEquipNameAndColor(_loc_41);
                        }
                        _loc_37 = this.getTextPoint(_loc_11);
                        this._content.addChild(_loc_37);
                        _loc_38 = this.getTextField(36, 61 + _loc_11 * 22);
                        if (_loc_34 > 1)
                        {
                            _loc_38.htmlText = _loc_36[0] + "*" + _loc_34;
                        }
                        else
                        {
                            _loc_38.htmlText = _loc_36[0];
                        }
                        _loc_38.textColor = _loc_36[1];
                        this._content.addChild(_loc_38);
                        _loc_11++;
                    }
                    _loc_26++;
                }
            }
            if (_loc_11 > 0)
            {
                _loc_42 = this.getTextField(18, 37);
                _loc_42.htmlText = LanguageCfgObj.getInstance().getByIndex("10168");
                this._content.addChild(_loc_42);
            }
            this._backImg.width = 170;
            this._backImg.height = 61 + _loc_11 * 22 + 10;
            return;
        }// end function

        private function getTextField(param1:int, param2:int) : TextField
        {
            var _loc_3:* = new TextField();
            _loc_3.filters = [new GlowFilter(0, 1, 3, 3)];
            _loc_3.autoSize = TextFieldAutoSize.LEFT;
            _loc_3.mouseEnabled = false;
            _loc_3.x = param1;
            _loc_3.y = param2;
            return _loc_3;
        }// end function

        private function getTextPoint(param1:int) : Sprite
        {
            var _loc_2:* = ToolKit.getNew("generalTextPoint");
            _loc_2.x = 18;
            _loc_2.y = 63 + param1 * 22;
            return _loc_2;
        }// end function

    }
}
