package com.f1.ui.box
{
    import com.f1.*;
    import com.f1.interfaces.ui.box.*;
    import com.f1.manager.keyboard.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.ui.timeCount.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.ui.*;

    public class SysCueBox extends BaseBox implements ICueBox
    {
        public var yesClose:Boolean = true;
        protected var closeBtn:BaseButton;
        public var yesBtn:BaseButton;
        protected var noBtn:BaseButton;
        protected var checkBtn:BaseButton;
        public var autoClose:Boolean;
        protected var _titleTxt:TextField;
        private var _titleLabel:String;
        protected var timeCount:TimeCountDown;
        protected var _yesFun:Function;
        protected var _noFun:Function;
        protected var _checkFun:Function;
        protected var txt:TextField;
        protected var params:Array;
        static const BLACK_FILTER:GlowFilter = new GlowFilter(0, 1, 4, 4, 2);

        public function SysCueBox(param1:String = "")
        {
            super(param1, 50);
            this.initUI();
            mute = true;
            return;
        }// end function

        public function get noFun() : Function
        {
            return this._noFun;
        }// end function

        public function set noFun(param1:Function) : void
        {
            this._noFun = param1;
            return;
        }// end function

        public function get yesFun() : Function
        {
            return this._yesFun;
        }// end function

        public function set titleLabel(param1:String) : void
        {
            this._titleLabel = param1;
            return;
        }// end function

        public function get titleLabel() : String
        {
            return this._titleLabel;
        }// end function

        public function set yesFun(param1:Function) : void
        {
            this._yesFun = param1;
            return;
        }// end function

        protected function initUI() : void
        {
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this.yesBtn = UITool.getStyleButton(getDisplayChildByName("yes_btn"));
            this.noBtn = UITool.getStyleButton(getDisplayChildByName("no_btn"));
            this.yesBtn.setText(LanguageCfgObj.getInstance().getByIndex("10004"));
            this.noBtn.setText(LanguageCfgObj.getInstance().getByIndex("10005"));
            this.checkBtn = new BaseButton(getDisplayChildByName("check_btn"), true);
            this.checkBtn.visible = false;
            this.checkBtn.setText(LanguageCfgObj.getInstance().getByIndex("10006"));
            this.txt = getDisplayChildByName("txt") as TextField;
            this._titleTxt = getDisplayChildByName("txt_title");
            if (this.txt)
            {
                this.txt.autoSize = TextFieldAutoSize.LEFT;
                this.txt.multiline = true;
                this.txt.wordWrap = true;
                this.txt.filters = [BLACK_FILTER];
            }
            this.yesBtn.addEventListener(MouseEvent.CLICK, this.__yes, false, 0, true);
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.noBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            this.checkBtn.addEventListener(MouseEvent.CLICK, this.__check, false, 0, true);
            layoutMC(this.closeBtn, Layout.RIGHT, 6, 6);
            return;
        }// end function

        public function set closeBtnVisible(param1:Boolean) : void
        {
            this.closeBtn.visible = param1;
            return;
        }// end function

        protected function __yes(event:Event = null) : void
        {
            Log.log("SysCueBox点击 确定__yes,str=" + this.txt.text);
            if (this.timeCount)
            {
                this.timeCount.reset();
                this.timeCount.removeEvtListener(Event.COMPLETE, this.__timeCountYes);
                Log.log("清除自动关闭");
            }
            if (this._yesFun != null)
            {
                this._yesFun.apply(null, this.params);
            }
            if (this.yesClose)
            {
                close();
            }
            return;
        }// end function

        protected function __close(event:MouseEvent = null) : void
        {
            if (this._noFun != null)
            {
                this._noFun.apply(null);
            }
            close();
            return;
        }// end function

        protected function __check(event:MouseEvent = null) : void
        {
            if (this._checkFun != null)
            {
                this._checkFun.apply(null, [this.checkBtn.selected]);
            }
            return;
        }// end function

        public function getTxt() : String
        {
            return this.txt.text;
        }// end function

        public function getHTML() : String
        {
            return this.txt.htmlText;
        }// end function

        public function equal(param1:ICueBox) : Boolean
        {
            if (this.getTxt() == param1.getTxt() && this.getHTML() == param1.getHTML() && this._yesFun == param1.yesFun && this._noFun == param1.noFun)
            {
                return true;
            }
            return false;
        }// end function

        public function cue(param1:String = "", param2:String = "", param3:Array = null, param4:Function = null, param5:Function = null, param6:uint = 2, param7 = null, param8:Boolean = false, param9:Function = null) : void
        {
            this._yesFun = param4;
            this._noFun = param5;
            this._checkFun = param9;
            if (param3 != null)
            {
                this.params = param3;
            }
            this.txt.htmlText = param1;
            this.resizeTxt();
            this.setTitle(param2);
            if (param8)
            {
                this.checkBtn.visible = true;
            }
            else
            {
                this.checkBtn.visible = false;
            }
            this.yesBtn.setText(LanguageCfgObj.getInstance().getByIndex("10004"));
            this.noBtn.setText(LanguageCfgObj.getInstance().getByIndex("10005"));
            if (param7)
            {
                if (param7 is String)
                {
                    this.yesBtn.setText(param7);
                }
                else if (param7 is Array)
                {
                    if (param7.length > 0)
                    {
                        this.yesBtn.setText(param7[0]);
                    }
                    if (param7.length > 1)
                    {
                        this.noBtn.setText(param7[1]);
                    }
                }
            }
            this.changeBtnMode(param6);
            this.open();
            this.txt.addEventListener(TextEvent.LINK, this.__link, false, 0, true);
            if (this.autoClose)
            {
                this.timeCount = new TimeCountDown(LanguageCfgObj.getInstance().getByIndex("10009"), this.yesBtn.labelTxt);
                this.timeCount.setCDTime(3, LanguageCfgObj.getInstance().getByIndex("10010"));
                this.timeCount.addEvtListener(Event.COMPLETE, this.__timeCountYes);
                Log.log("弹出自动关闭窗口，如三国乱战战斗结束");
            }
            return;
        }// end function

        private function __link(event:TextEvent) : void
        {
            FrameworkGlobal.stage.dispatchEvent(new SysCueEvent(SysCueEvent.LINK, event.text));
            close();
            return;
        }// end function

        private function __timeCountYes(event:Event) : void
        {
            Log.log("===自动关闭窗口，如三国乱战战斗结束");
            this.__yes(event);
            return;
        }// end function

        public function cueHTML(param1:String = "", param2:Array = null, param3:Function = null, param4:Function = null, param5:uint = 2) : void
        {
            this._yesFun = param3;
            this._noFun = param4;
            this.txt.htmlText = param1;
            this.resizeTxt();
            if (param2 != null)
            {
                this.params = param2;
            }
            this.changeBtnMode(param5);
            this.open();
            return;
        }// end function

        private function resizeTxt() : void
        {
            var _loc_1:* = this.txt.height;
            if (_loc_1 < 38)
            {
                this.txt.y = 70;
            }
            else if (_loc_1 < 50)
            {
                this.txt.y = 60;
            }
            else
            {
                this.txt.y = 50;
            }
            return;
        }// end function

        private function changeBtnMode(param1:uint) : void
        {
            if (param1 == 1)
            {
                this.noBtn.visible = false;
                this.yesBtn.visible = true;
                layoutMC(this.yesBtn, Layout.BOTTOM_CENTER, 0, 12);
            }
            else if (param1 == 2)
            {
                this.noBtn.visible = true;
                layoutMC(this.noBtn, Layout.BOTTOM_CENTER, 60, 12);
                this.yesBtn.visible = true;
                layoutMC(this.yesBtn, Layout.BOTTOM_CENTER, -60, 12);
            }
            return;
        }// end function

        public function setTitle(param1:String) : void
        {
            this._titleTxt.htmlText = "<b>" + param1 + "</b>";
            this._titleLabel = param1;
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            KeyboardManager.removeEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler, false);
            KeyboardManager.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler, false, 2, true);
            return;
        }// end function

        override public function keyUpHandler(event:KeyboardEvent, param2:Boolean = false) : void
        {
            super.keyUpHandler(event, true);
            switch(event.keyCode)
            {
                case Keyboard.ENTER:
                {
                    this.__yes();
                    break;
                }
                case Keyboard.ESCAPE:
                {
                    this.__close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
