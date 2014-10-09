package com.game.signwage.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.offline.control.*;
    import com.game.worldlevel.model.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class OfflineExpItem extends Component
    {
        private var _question_Income:Sprite;
        private var _question_Num:Sprite;
        private var _type:int;
        private var _numImg:ImgNumber;
        private var _icon_sp:Sprite;
        private var text:TextField;
        private var _applyBtn:BaseButton;
        private var goldNum:uint = 0;
        private var moneyNum:uint = 0;

        public function OfflineExpItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            initComponentUI(param1);
            this.initUI();
            this.addlistener();
            return;
        }// end function

        private function initUI() : void
        {
            this.text = getDisplayChildByName("txt1");
            this._icon_sp = getDisplayChildByName("pic");
            this._question_Income = getDisplayChildByName("symbol_1");
            this._question_Num = getDisplayChildByName("symbol_2");
            this._applyBtn = new BaseButton(getDisplayChildByName("btn_apply"));
            this._numImg = new ImgNumber();
            this._numImg.move(196, 40);
            this._numImg.scale = 0.65;
            addChild(this._numImg);
            return;
        }// end function

        private function addlistener() : void
        {
            this._applyBtn.addEvtListener(MouseEvent.CLICK, this.__applyClick);
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        private function __applyClick(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = UserObj.getInstance().playerInfo.gold;
            switch(this._type)
            {
                case 1:
                {
                    OfflineControl.getInstance().getSingleExp();
                    break;
                }
                case 2:
                {
                    if (UserObj.getInstance().playerInfo.money >= this.moneyNum)
                    {
                        OfflineControl.getInstance().getDoubleEx();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11151"));
                    }
                    break;
                }
                case 5:
                {
                    if (UserObj.getInstance().playerInfo.vipid < 1)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11152"));
                    }
                    else if (_loc_2 < this.goldNum)
                    {
                        MapControl.getInstance().showRechargeD();
                    }
                    else
                    {
                        OfflineControl.getInstance().getThreeEx();
                    }
                    break;
                }
                case 10:
                {
                    _loc_3 = VIPShowCfgObj.getInstance().getTenOffline();
                    if (UserObj.getInstance().playerInfo.vipid < _loc_3)
                    {
                        Global.popManager.addedToMouseCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12186"), [_loc_3]));
                    }
                    else if (_loc_2 < this.goldNum)
                    {
                        MapControl.getInstance().showRechargeD();
                    }
                    else
                    {
                        OfflineControl.getInstance().getTenEx();
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

        public function update() : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_1:* = UserObj.getInstance().playerInfo;
            var _loc_2:* = OfflineControl.getInstance().getExp;
            var _loc_3:* = LevelExpCfgObj.getInstance().getQ_rexp(_loc_1.jobkind, _loc_1.level);
            _loc_2 = _loc_2 * (0.3 * _loc_3);
            if (WorldLevelData.getInstance().isWorldLevelEnabled() && WorldLevelData.getInstance().isAdditionActive())
            {
                _loc_2 = _loc_2 * (1 + WorldLevelData.getInstance().getExpRecoverAddition() * 0.01);
            }
            _loc_2 = Math.floor(_loc_2);
            var _loc_4:* = OfflineControl.getInstance().getExp;
            var _loc_5:* = _loc_1.level;
            var _loc_6:* = Math.floor(_loc_2 * this._type);
            var _loc_7:* = _loc_6.toString();
            var _loc_8:* = ToolKit.getMoneyStringByString(_loc_7);
            this._numImg.setNumber(_loc_8, 24, -3);
            StringTip.dispose(this._applyBtn);
            if (_loc_2 > 0)
            {
                this._applyBtn.enabled = true;
            }
            else
            {
                this._applyBtn.enabled = false;
            }
            _loc_9 = VIPShowCfgObj.getInstance().getTenOffline();
            if (this._type == 1)
            {
                this.text.text = "";
                this._applyBtn.setText(LanguageCfgObj.getInstance().getByIndex("11153"));
            }
            else if (this._type == 2)
            {
                this.moneyNum = Math.ceil(OfflineControl.getInstance().getExp * LevelExpCfgObj.getInstance().getQ_remoney(_loc_1.job, _loc_5) * 24);
                this.text.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12187"), [ToolKit.getMoneyString(this.moneyNum)]);
                StringTip.create(this._applyBtn, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12188"), [this.moneyNum]));
                this._applyBtn.setText(LanguageCfgObj.getInstance().getByIndex("11154"));
            }
            else if (this._type == 5)
            {
                _loc_10 = Math.ceil(0.2 * OfflineControl.getInstance().getExp);
                this.goldNum = _loc_10;
                this.text.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12189"), [ToolKit.getMoneyString(_loc_10)]);
                StringTip.create(this._applyBtn, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12190"), [ToolKit.getMoneyString(_loc_10)]));
                this._applyBtn.setText(LanguageCfgObj.getInstance().getByIndex("11155"));
            }
            else if (this._type == 10)
            {
                _loc_10 = Math.ceil(0.2 * OfflineControl.getInstance().getExp) * 2;
                this.goldNum = _loc_10;
                this._applyBtn.setText(LanguageCfgObj.getInstance().getByIndex("11155"));
                if (_loc_1.vipid >= _loc_9)
                {
                    this._question_Income.visible = false;
                    this._question_Num.visible = false;
                    this._icon_sp.visible = true;
                    this._numImg.visible = true;
                    this._applyBtn.visible = true;
                    this.text.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12191"), [_loc_9, ToolKit.getMoneyString(_loc_10)]);
                    StringTip.create(this._applyBtn, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12192"), [ToolKit.getMoneyString(_loc_10)]));
                }
                else
                {
                    this._question_Income.visible = true;
                    this._question_Num.visible = true;
                    this._icon_sp.visible = false;
                    this._applyBtn.visible = false;
                    this._numImg.visible = false;
                    this.text.htmlText = "";
                    StringTip.create(this._applyBtn, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12192"), [ToolKit.getMoneyString(_loc_10)]));
                }
            }
            return;
        }// end function

    }
}
