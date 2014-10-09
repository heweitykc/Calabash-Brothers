package com.game.login.view
{
    import com.adobe.serialization.json.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;

    public class PlatRegistPanel extends BaseBox
    {
        private var _name_txt:TextField;
        private var _pwd_txt:TextField;
        private var _reg_btn:BaseButton;
        private var _cue1:TextField;
        private var _cue2:TextField;

        public function PlatRegistPanel()
        {
            loadDisplay("res/platregistpanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("plat_reg_panel");
            this.initUI();
            this._reg_btn.addEvtListener(MouseEvent.CLICK, this.__reg);
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._name_txt = getDisplayChildByName("user_name_txt");
            this._name_txt.maxChars = 22;
            this._name_txt.restrict = "0-9a-z";
            FrameworkGlobal.stage.focus = this._name_txt;
            this._pwd_txt = getDisplayChildByName("pwd_txt");
            this._pwd_txt.maxChars = 16;
            this._pwd_txt.displayAsPassword = true;
            this._pwd_txt.restrict = "0-9a-z!@#$%&*";
            this._cue1 = getDisplayChildByName("cue1_txt");
            this._cue2 = getDisplayChildByName("cue2_txt");
            this._reg_btn = new BaseButton(getDisplayChildByName("reg_btn"));
            this._reg_btn.setText(LanguageCfgObj.getInstance().getByIndex("10886"));
            return;
        }// end function

        private function __reg(event:MouseEvent) : void
        {
            if (this.checkInput())
            {
                ToolKit.loadVarTool("http://dts.97wanba.net/user.php?action=register" + "&user_name=" + this._name_txt.text + "&password=" + this._pwd_txt.text + "&rand_name=" + Params.username, this.regResponse);
            }
            return;
        }// end function

        private function checkInput() : Boolean
        {
            var _loc_1:* = this._name_txt.text;
            var _loc_2:* = this._pwd_txt.text;
            if (!_loc_1)
            {
                this._cue1.text = LanguageCfgObj.getInstance().getByIndex("10887");
                return false;
            }
            if (!_loc_2)
            {
                this._cue2.text = LanguageCfgObj.getInstance().getByIndex("10888");
                return false;
            }
            this._cue1.text = "";
            this._cue2.text = "";
            return true;
        }// end function

        private function regResponse(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = JSON.decode(param1);
            if (_loc_2.code == 3)
            {
                Params.needPlatReg = false;
                SimpleTip.show(LanguageCfgObj.getInstance().getByIndex("10889"));
                close();
            }
            else
            {
                _loc_3 = "";
                switch(_loc_2.code)
                {
                    case 1:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10890");
                        break;
                    }
                    case -1:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10891");
                        break;
                    }
                    case -2:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10892");
                        break;
                    }
                    case -3:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10893");
                        break;
                    }
                    case 2:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10894");
                        break;
                    }
                    case -4:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10895");
                        break;
                    }
                    case 3:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10889");
                        break;
                    }
                    case -5:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10897");
                        break;
                    }
                    case -6:
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("10898");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this._cue1.text = _loc_3;
            }
            return;
        }// end function

    }
}
