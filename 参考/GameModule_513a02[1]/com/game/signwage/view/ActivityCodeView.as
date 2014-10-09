package com.game.signwage.view
{
    import com.*;
    import com.adobe.serialization.json.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.reqhttp.control.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ActivityCodeView extends Component
    {
        private var initInputText:String;
        private var getBtn:BaseButton;
        private var errorTxt:TextField;
        private var inputTxt:TextField;
        private var helpTxt:TextField;
        private var _preTimer:int;

        public function ActivityCodeView()
        {
            this.initInputText = LanguageCfgObj.getInstance().getByIndex("11146");
            initComponentUI("signup.activationCode");
            this.move(15, 86);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            this.getBtn = new BaseButton(getDisplayChildByName("getBtn"));
            this.errorTxt = getDisplayChildByName("errorTxt");
            this.inputTxt = getDisplayChildByName("inputTxt");
            this.inputTxt.maxChars = 32;
            this.helpTxt = getDisplayChildByName("helpTxt");
            this.helpTxt.text = LanguageCfgObj.getInstance().getByIndex("11147");
            return;
        }// end function

        private function addListener() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            addEvtListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEvtListener(Event.REMOVED_FROM_STAGE, this.onremovedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            switch(event.target)
            {
                case this.getBtn:
                {
                    _loc_2 = getTimer();
                    if (this._preTimer != 0 && _loc_2 - this._preTimer < 200)
                    {
                        return;
                    }
                    this._preTimer = _loc_2;
                    ReqHttpControl.getInstance().getCardValidate(this.inputTxt.text, this.returnFun, this.errorFun);
                    break;
                }
                case this.inputTxt:
                {
                    if (this.inputTxt.text == this.initInputText)
                    {
                        this.inputTxt.text = "";
                    }
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function returnFun(param1:String) : void
        {
            var obj:Object;
            var data:* = param1;
            try
            {
                obj = JSON.decode(data);
            }
            catch (e:Error)
            {
                errorTxt.text = LanguageCfgObj.getInstance().getByIndex("11148");
                return;
            }
            switch(obj.code)
            {
                case 1:
                {
                    Global.popManager.addedToSystem(obj.msg);
                    this.errorTxt.htmlText = "<font color=\'#1eff00\'>" + LanguageCfgObj.getInstance().getByIndex("12185") + "</font>";
                    break;
                }
                default:
                {
                    this.errorTxt.text = obj.msg;
                    break;
                }
            }
            return;
        }// end function

        private function errorFun() : void
        {
            this.errorTxt.text = LanguageCfgObj.getInstance().getByIndex("11150");
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            this.inputTxt.text = this.initInputText;
            this.errorTxt.text = "";
            this.inputTxt.addEventListener(TextEvent.TEXT_INPUT, this.__reset);
            return;
        }// end function

        private function __reset(event:TextEvent) : void
        {
            this.errorTxt.text = "";
            return;
        }// end function

        private function onremovedToStage(event:Event) : void
        {
            this.inputTxt.removeEventListener(Event.ACTIVATE, this.__reset);
            return;
        }// end function

    }
}
