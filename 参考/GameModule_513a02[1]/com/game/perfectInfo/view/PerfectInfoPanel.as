package com.game.perfectInfo.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.perfectInfo.control.*;
    import com.game.prompt.utils.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class PerfectInfoPanel extends BaseBox
    {
        private var INPUT_NAME:String;
        private var INPUT_ID:String;
        private var _closeBtn:BaseButton;
        private var _nameTxt:TextField;
        private var _idTxt:TextField;
        private var _idTipsTxt:TextField;
        private var _submitInfoBtn:BaseButton;
        private var _getRewardBtn:BaseButton;
        private var _hasGetRewardBtn:MovieClip;
        private var _rewardsbox:HBox;
        private var _hasValidate:Boolean = false;
        private var _rewards:Array;
        private const PROVINCE:Object;
        private static const LANG:String = "lang_perfectInfo";
        private static var swf:String = "res/perfectInfo.swf";

        public function PerfectInfoPanel()
        {
            this.PROVINCE = {11:"北京", 12:"天津", 13:"河北", 14:"山西", 15:"内蒙古", 21:"辽宁", 22:"吉林", 23:"黑龙江", 31:"上海", 32:"江苏", 33:"浙江", 34:"安徽", 35:"福建", 36:"江西", 37:"山东", 41:"河南", 42:"湖北", 43:"湖南", 44:"广东", 45:"广西", 46:"海南", 50:"重庆", 51:"四川", 52:"贵州", 53:"云南", 54:"西藏", 61:"陕西", 62:"甘肃", 63:"青海", 64:"宁夏", 65:"新疆", 71:"台湾", 81:"香港", 82:"澳门", 91:"国外"};
            this.INPUT_NAME = LanguageCfgObj.getInstance().getByIndex("pi001", LANG);
            this.INPUT_ID = LanguageCfgObj.getInstance().getByIndex("pi002", LANG);
            loadDisplay(swf);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("perfectInfo_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            this._submitInfoBtn = new BaseButton(getDisplayChildByName("submitInfoBtn"));
            this._getRewardBtn = new BaseButton(getDisplayChildByName("getRewardBtn"));
            this._hasGetRewardBtn = getDisplayChildByName("hasGetRewardBtn");
            this._hasGetRewardBtn.visible = false;
            this._getRewardBtn.enabled = false;
            this._nameTxt = getDisplayChildByName("nameTxt");
            this._nameTxt.restrict = String.fromCharCode(19968) + "-" + String.fromCharCode(40869);
            this._nameTxt.maxChars = 15;
            this._idTxt = getDisplayChildByName("idTxt");
            this._idTxt.restrict = "0-9,x";
            this._idTxt.maxChars = 18;
            this._idTipsTxt = getDisplayChildByName("idTipsTxt");
            this._rewardsbox = new HBox();
            this._rewardsbox.horizontal = true;
            this._rewardsbox.intervalX = 9;
            this._rewardsbox.oneRow = 9;
            this._rewards = GlobalCfgObj.getInstance().getCompleteInfoRewards();
            var _loc_1:* = this._rewards.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1)
            {
                
                _loc_2 = new IconItem("commonRewardBox2_40");
                _loc_2.image.move(4, 4);
                _loc_2.setInfo(this._rewards[_loc_3]);
                this._rewardsbox.add(_loc_2);
                _loc_3++;
            }
            addChild(this._rewardsbox);
            this._rewardsbox.move(27, 340);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            switch(event.target)
            {
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                case this._submitInfoBtn:
                {
                    _loc_2 = this._nameTxt.text;
                    _loc_3 = this._idTxt.text;
                    if (_loc_2 == this.INPUT_NAME || _loc_2.length == 0)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("pi004", LANG));
                        return;
                    }
                    if (_loc_3 == this.INPUT_ID || !(_loc_3.length == 15 || _loc_3.length == 18))
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("pi005", LANG));
                        return;
                    }
                    if (this.validateIdCard(_loc_3))
                    {
                        PerfectInfoControl.getInstance().reqSubmitImproveData(_loc_2, _loc_3);
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("pi003", LANG));
                    }
                    break;
                }
                case this._getRewardBtn:
                {
                    PerfectInfoControl.getInstance().reqCollectImproveReward();
                    this.gainRewardResult(true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function gainRewardResult(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param1)
            {
                if (this._rewardsbox)
                {
                    _loc_2 = 0;
                    _loc_2 = this._rewardsbox.length;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_2)
                    {
                        
                        _loc_3 = this._rewardsbox.getContent(_loc_4) as IconItem;
                        ItemGetAnim.doFlyToBackPack(_loc_3.info.q_id, _loc_3.localToGlobal(new Point(0, 0)));
                        _loc_4++;
                    }
                }
                this._hasGetRewardBtn.visible = true;
                this._getRewardBtn.visible = false;
            }
            return;
        }// end function

        public function submitInfoResult(param1:Boolean) : void
        {
            if (param1)
            {
                this._submitInfoBtn.enabled = false;
                this._nameTxt.mouseEnabled = false;
                this._idTxt.mouseEnabled = false;
                this._getRewardBtn.enabled = true;
                this._hasValidate = true;
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("pi010", LANG));
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            if (!this._hasValidate)
            {
                this._idTxt.text = this.INPUT_ID;
                this._nameTxt.text = this.INPUT_NAME;
            }
            this._idTxt.addEventListener(FocusEvent.FOCUS_IN, this.focusInHanler);
            this._idTxt.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHanler);
            this._nameTxt.addEventListener(FocusEvent.FOCUS_IN, this.focusInHanler);
            this._nameTxt.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHanler);
            return;
        }// end function

        private function focusInHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this._idTxt:
                {
                    if (event.target.text == this.INPUT_ID)
                    {
                        event.target.text = "";
                    }
                    break;
                }
                case this._nameTxt:
                {
                    if (event.target.text == this.INPUT_NAME)
                    {
                        event.target.text = "";
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

        private function focusOutHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this._idTxt:
                {
                    if (event.target.text == "")
                    {
                        event.target.text = this.INPUT_ID;
                    }
                    break;
                }
                case this._nameTxt:
                {
                    if (event.target.text == "")
                    {
                        event.target.text = this.INPUT_NAME;
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

        private function validateIdCard(param1:String) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1.length == 15)
            {
                param1 = this.IdCard15to18(param1);
            }
            if (param1.length == 18)
            {
                if (this.getVerifyNumber(param1.substr(0, 17)) == param1.substr(17, 1))
                {
                    _loc_2 = this.PROVINCE[param1.substr(0, 2)];
                    if (_loc_2 != null)
                    {
                        Log.log("PerfectInfoPanel::身份地区:" + _loc_2);
                        _loc_3 = int(param1.substr(6, 4));
                        _loc_4 = int(param1.substr(10, 2));
                        _loc_5 = int(param1.substr(12, 2));
                        if (this.checkdate(_loc_3, _loc_4, _loc_5))
                        {
                            return true;
                        }
                        return false;
                    }
                    else
                    {
                        Log.log("PerfectInfoPanel::身份地区验证错误:" + param1.substr(0, 2));
                        return false;
                    }
                }
                else
                {
                    Log.log("PerfectInfoPanel::身份验证码错误");
                    return false;
                }
            }
            else
            {
                return false;
            }
        }// end function

        private function checkdate(param1:int, param2:int, param3:int) : Boolean
        {
            if (param2 > 0 && param2 < 13 && param3 > 0 && param3 < 32 && param1 > 0)
            {
                return true;
            }
            return false;
        }// end function

        private function IdCard15to18(param1:String) : String
        {
            if (param1.length != 15)
            {
                Log.error("身份证非15位");
            }
            var _loc_2:* = "";
            if (["996", "997", "998", "999"].indexOf(param1.substr(12, 3)) != -1)
            {
                _loc_2 = param1.substr(0, 6) + "18" + param1.substr(6, 9);
            }
            else
            {
                _loc_2 = param1.substr(0, 6) + "19" + param1.substr(6, 9);
            }
            return _loc_2 + this.getVerifyNumber(_loc_2);
        }// end function

        private function getVerifyNumber(param1:String) : String
        {
            if (param1.length != 17)
            {
                Log.error("非17位");
            }
            var _loc_2:* = param1.split("").reverse();
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < 17)
            {
                
                _loc_3 = _loc_3 + _loc_2[_loc_4] * (Math.pow(2, (_loc_4 + 1)) % 11);
                _loc_4++;
            }
            var _loc_5:* = (12 - _loc_3 % 11) % 11;
            return String(_loc_5 == 10 ? ("x") : (_loc_5));
        }// end function

    }
}
