package com.f1.ui.box
{
    import com.f1.*;
    import com.f1.interfaces.ui.box.*;
    import com.f1.manager.keyboard.*;
    import com.f1.manager.sound.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class BaseBox extends Component implements IBaseBox
    {
        protected var _dragBarH:uint;
        public var maskMC:Sprite;
        private var maskBG:Shape;
        private var preloaderMC:MovieClip;
        private var infoTxt:TextField;
        protected var _combinedBox:Array;
        protected var _peaceBox:Array;
        private var _intendToClose:Boolean;
        private var _isOpen:Boolean;
        public static const HIDE:uint = 1;
        public static const SHOW:uint = 0;
        public static const CLOSE_BTN_X_VAL:int = 0;
        public static const CLOSE_BTN_Y_VAL:int = 9;
        public static const HELP_BTN_X_VAL:int = 32;

        public function BaseBox(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this._peaceBox = [];
            this.initBaseBoxUI(param1, param2, param3, param4);
            return;
        }// end function

        public function get peaceBox() : Array
        {
            return this._peaceBox;
        }// end function

        public function get combinedBox() : Array
        {
            if (this._combinedBox == null)
            {
                this._combinedBox = [];
            }
            return this._combinedBox;
        }// end function

        public function get dragBarH() : uint
        {
            return this._dragBarH;
        }// end function

        public function set dragBarH(param1:uint) : void
        {
            this._dragBarH = param1;
            return;
        }// end function

        public function get isOpen() : Boolean
        {
            return this._isOpen;
        }// end function

        protected function initBaseBoxUI(param1, param2:uint = 60, param3:String = null, param4:Boolean = true) : void
        {
            initComponentUI(param1, param3);
            if (param4)
            {
                if (bgMc)
                {
                    bgMc.buttonMode = true;
                    bgMc.useHandCursor = false;
                }
            }
            this.dragBarH = param2;
            if ((param1 || param3) && param2 > 1)
            {
                this.addEventListener(MouseEvent.MOUSE_DOWN, this.__drag);
            }
            else if (this.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
                this.removeEventListener(MouseEvent.MOUSE_DOWN, this.__drag);
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            this.closeLoading();
            super.displayReady();
            return;
        }// end function

        public function showLoading(param1:String = null, param2:Number = 0, param3:Boolean = true) : void
        {
            var __w:int;
            var __h:int;
            var msg:* = param1;
            var bgAlpha:* = param2;
            var loading:* = param3;
            this.closeLoading();
            this.maskMC = new Sprite();
            this.maskMC.mouseChildren = false;
            this.maskMC.addEventListener(MouseEvent.CLICK, function (event:Event) : void
            {
                return;
            }// end function
            , false, 0, true);
            this.maskMC.graphics.beginFill(0, bgAlpha);
            this.maskMC.graphics.drawRect(0, 0, _w, _h);
            addChild(this.maskMC);
            ToolKit.bringToTop(this.maskMC);
            this.maskBG = new Shape();
            this.maskMC.addChild(this.maskBG);
            this.preloaderMC = ToolKit.getNew("connect_loader2");
            if (this.preloaderMC)
            {
                this.preloaderMC.x = int(_w / 2);
                this.preloaderMC.y = int(_h / 4);
                if (loading)
                {
                    this.maskMC.addChild(this.preloaderMC);
                }
                this.infoTxt = new TextField();
                this.infoTxt.wordWrap = true;
                this.infoTxt.defaultTextFormat = new TextFormat(UITool.FONT, 14, 16777215, null, null, null, null, null, TextFormatAlign.CENTER);
                this.infoTxt.width = int(_w / 3);
                if (msg)
                {
                    this.infoTxt.text = msg;
                }
                this.infoTxt.x = int(_w / 3);
                this.infoTxt.y = this.preloaderMC.y + 25;
                this.infoTxt.filters = [new GlowFilter(0, 0.5, 1, 1, 5)];
                this.maskMC.addChild(this.infoTxt);
                __w = this.infoTxt.width + 20;
                __h = this.preloaderMC.height + this.infoTxt.textHeight + 30;
                this.maskBG.graphics.beginFill(0, 0.2);
                this.maskBG.graphics.drawRoundRect(this.infoTxt.x - 10, this.preloaderMC.y - 25, __w, __h, 10, 10);
                this.maskBG.visible = loading;
            }
            return;
        }// end function

        public function showLoadingProgress(param1:uint) : void
        {
            if (this.infoTxt)
            {
                this.infoTxt.text = Math.min(100, Math.max(0, param1)) + "%";
            }
            return;
        }// end function

        public function closeLoading() : void
        {
            if (this.maskMC && this.maskMC.parent)
            {
                while (this.maskMC.numChildren > 0)
                {
                    
                    this.maskMC.removeChildAt(0);
                }
                this.maskMC.parent.removeChild(this.maskMC);
            }
            return;
        }// end function

        public function setBottomAlpha(param1:Number) : void
        {
            return;
        }// end function

        private function __drag(event:MouseEvent) : void
        {
            ToolKit.bringToTop(this);
            var _loc_2:* = new Point(event.stageX, event.stageY);
            _loc_2 = this.parent.globalToLocal(_loc_2);
            if (_loc_2.y - this.y < this.dragBarH)
            {
                if (!(event.target is BaseButton) && !(event.target is SimpleButton))
                {
                    this.startDrag();
                    this.stage.addEventListener(MouseEvent.MOUSE_UP, this.__stopDrag, false, 0, true);
                    event.stopImmediatePropagation();
                    return;
                }
            }
            return;
        }// end function

        private function __stopDrag(event:MouseEvent) : void
        {
            this.stopDrag();
            if (stage)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, this.__stopDrag);
            }
            this.move(int(this.x), int(this.y));
            return;
        }// end function

        public function close() : void
        {
            if (this.stage)
            {
                this.stage.focus = this.stage;
            }
            KeyboardManager.removeEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler, false);
            this._intendToClose = true;
            dispatchEvent(new BoxEvent(BoxEvent.SHOW_HIDE, HIDE));
            if (!SoundManager.onlyPlayKeySound)
            {
                SoundManager.play("1", false, true, null, 0, SoundManager.volume);
            }
            this._isOpen = false;
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            if (this._intendToClose)
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        public function open() : void
        {
            if (!SoundManager.onlyPlayKeySound)
            {
                SoundManager.play("1", false, true, null, 0, SoundManager.volume);
            }
            if (this.isOpen)
            {
                return;
            }
            this._intendToClose = false;
            KeyboardManager.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler, false, 1, true);
            addEvtListener(MouseEvent.CLICK, this.__click, true);
            dispatchEvent(new BoxEvent(BoxEvent.SHOW_HIDE, SHOW));
            if (this.stage)
            {
                this.stage.focus = this;
            }
            this._isOpen = true;
            return;
        }// end function

        public function keyUpHandler(event:KeyboardEvent, param2:Boolean = false) : void
        {
            if (param2)
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        public function openOrClose() : void
        {
            if (this.isOpen)
            {
                this.close();
            }
            else
            {
                this.open();
            }
            return;
        }// end function

        override protected function onLoadingStart() : void
        {
            this.showLoading(LanguageCfgObj.getInstance().getByIndex("10003"));
            return;
        }// end function

        public function changeToActive() : void
        {
            return;
        }// end function

    }
}
