package com.f1.ui.scroller
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ScrollPanel extends Component
    {
        protected var scrollBar:DisplayObjectContainer;
        private var _upBtn:BaseButton;
        private var _downBtn:BaseButton;
        private var _thumbBtn:BaseButton;
        private var _trackMC:Sprite;
        private var _carve:Sprite;
        private var _direct:int;
        protected var _horizontal:Boolean;
        private var DIRECT_STOP:int = 0;
        private var DIRECT_UP:int = 1;
        private var DIRECT_DOWN:int = -1;
        private var moveStep:uint = 8;
        public var autoBgHeight:Boolean;
        private var _content:DisplayObject;
        private var contentMask:Shape;
        private var trackSt:uint;
        private var trackLength:uint;
        private var contentTrackLength:uint;
        private var thumbBtnDragRect:Rectangle;
        private var _offsetY:int;
        private var _barCanVisible:Boolean;
        private var _isTrueThumbH:Boolean = true;
        private static const MOVE_STEP_MIN:uint = 8;
        private static const MOVE_STEP_MAX:uint = 20;

        public function ScrollPanel(param1:uint, param2:uint, param3:String = "scrollBar1", param4:String = null)
        {
            this.scrollBar = ToolKit.getNew(param3);
            this.initUI();
            this.contentMask = new Shape();
            this.contentMask.graphics.beginFill(0, 0);
            this.contentMask.graphics.drawRect(0, 0, 1, 1);
            this.contentMask.graphics.endFill();
            addChild(this.contentMask);
            this.setWH(param1, param2);
            this.scrollBarLeft();
            var _loc_5:* = ToolKit.creatRect(0, 0, param1, param2);
            this.addEventListener(MouseEvent.MOUSE_WHEEL, this.__wheel);
            _loc_5.addEventListener(MouseEvent.MOUSE_WHEEL, this.__wheel);
            JSTools.addWheelListener(this.__jsMouseWheeled);
            addChild(_loc_5);
            super(null, param4);
            return;
        }// end function

        public function get barCanVisible() : Boolean
        {
            return this._barCanVisible;
        }// end function

        public function set barCanVisible(param1:Boolean) : void
        {
            this._barCanVisible = param1;
            return;
        }// end function

        public function get offsetY() : int
        {
            return this._offsetY;
        }// end function

        public function set offsetY(param1:int) : void
        {
            this._offsetY = param1;
            this.contentMask.height = _h - param1;
            this.contentMask.y = param1;
            return;
        }// end function

        public function get content() : DisplayObject
        {
            return this._content;
        }// end function

        public function set content(param1:DisplayObject) : void
        {
            this._content = param1;
            this._content.mask = this.contentMask;
            if (this._content.x == 0)
            {
                this._content.x = this.contentMask.x + 1;
            }
            addChild(this._content);
            this.setChildIndex(this.scrollBar, (numChildren - 1));
            this.updateThumb();
            return;
        }// end function

        public function get scroll() : DisplayObjectContainer
        {
            return this.scrollBar;
        }// end function

        public function scrollBarLeft(param1:Boolean = false) : void
        {
            if (param1)
            {
                this.scrollBar.x = 0;
                this.contentMask.x = this.scrollBar.x + this.scrollBar.width;
            }
            else
            {
                this.scrollBar.x = _w - this._upBtn.width;
                this.contentMask.x = 0;
            }
            if (this.content)
            {
                this.content.x = this.contentMask.x + 1;
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._upBtn = new BaseButton(this.scrollBar.getChildByName("arrowUpMC"));
            this._downBtn = new BaseButton(this.scrollBar.getChildByName("arrowDownMC"));
            this._trackMC = Sprite(this.scrollBar.getChildByName("track"));
            this._thumbBtn = new BaseButton(this.scrollBar.getChildByName("thumbMC"));
            this._thumbBtn.x = (this._trackMC.width - this._thumbBtn.width) / 2;
            this._carve = Sprite(this.scrollBar.getChildByName("carve"));
            if (this._carve)
            {
                this._carve.x = (this._thumbBtn.width - this._carve.width) / 2;
                this._thumbBtn.addChild(this._carve);
            }
            this._upBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__upBtnDown);
            this._downBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__downBtnDown);
            this._thumbBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__thumbBtnDown);
            this.trackSt = this._upBtn.height;
            this._thumbBtn.y = this.trackSt;
            addChild(this.scrollBar);
            this.unEnableBar();
            this.updateTrackLength();
            return;
        }// end function

        private function __wheel(event:MouseEvent) : void
        {
            if (this._content && this._content.height > this.getlength())
            {
                this.mouseWheeled(event.delta / 3);
            }
            return;
        }// end function

        private function __jsMouseWheeled(param1:int, param2:int, param3:int, param4:Array) : void
        {
            if (ToolKit.hasChildInArray(this, param4))
            {
                this.mouseWheeled(param1 / 3);
            }
            return;
        }// end function

        private function mouseWheeled(param1:int) : void
        {
            this._direct = param1;
            this.moveStep = 4 * MOVE_STEP_MIN;
            this.stepMove();
            return;
        }// end function

        public function getlength() : uint
        {
            return _h;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            _w = param1;
            this.contentMask.width = param1;
            this.setLength(param2);
            this.scrollBarLeft();
            return;
        }// end function

        public function setLength(param1:uint) : void
        {
            _h = param1;
            this.contentMask.height = param1;
            this._trackMC.height = param1 - this._downBtn.height * 2;
            this._downBtn.y = param1 - this._downBtn.height;
            this.updateTrackLength();
            this.updateThumb();
            this.updateThumbBtnPosition();
            return;
        }// end function

        private function updateTrackLength() : void
        {
            this.trackLength = this.getlength() - this._downBtn.height - this._upBtn.height;
            return;
        }// end function

        public function updateThumb() : void
        {
            var _loc_1:* = 0;
            if (this._content)
            {
                if (this._content.height > this.getlength())
                {
                    _loc_1 = this.trackLength * this.getlength() / this._content.height;
                    if (this._carve)
                    {
                        if (_loc_1 > this._carve.height + 4)
                        {
                            this._isTrueThumbH = true;
                            this._thumbBtn.setHeight(_loc_1);
                        }
                        else
                        {
                            this._isTrueThumbH = false;
                            _loc_1 = this._carve.height + 4;
                            this._thumbBtn.setHeight(_loc_1);
                        }
                        this._carve.y = uint(_loc_1 / 2 - this._carve.height / 2);
                    }
                    else
                    {
                        this._isTrueThumbH = true;
                        this._thumbBtn.setHeight(_loc_1);
                    }
                    this.thumbBtnDragRect = new Rectangle((this._trackMC.width - this._thumbBtn.width) / 2, this.trackSt, 0, this.trackLength - this._thumbBtn.height);
                    this.contentTrackLength = this.content.height - this.getlength();
                    this.updateThumbBtnPosition();
                    this.enableBar();
                    if (this.barCanVisible)
                    {
                        this.scrollBar.visible = true;
                    }
                }
                else
                {
                    this.contentTrackLength = 0;
                    if (this.barCanVisible)
                    {
                        this.scrollBar.visible = false;
                    }
                    this.unEnableBar();
                }
                this.__thumbBtnMove();
                if (this.autoBgHeight)
                {
                    if (bgMc)
                    {
                        bgMc.height = Math.min(this._content.height, this._h) + 3;
                    }
                }
            }
            return;
        }// end function

        private function unEnableBar() : void
        {
            this._upBtn.mouseEnabled = false;
            this._downBtn.mouseEnabled = false;
            this._thumbBtn.visible = false;
            return;
        }// end function

        private function enableBar() : void
        {
            this._upBtn.mouseEnabled = true;
            this._downBtn.mouseEnabled = true;
            this._thumbBtn.visible = true;
            return;
        }// end function

        public function scrollToBottom() : void
        {
            this.scrollTo(this.getlength() - this._thumbBtn.height - this._downBtn.height);
            return;
        }// end function

        public function scrollToByContent(param1:uint) : void
        {
            this._content.y = -param1;
            this.updateThumbBtnPosition();
            return;
        }// end function

        public function scrollTo(param1:Number) : void
        {
            if (param1 <= this.trackSt)
            {
                this._thumbBtn.y = this.trackSt;
            }
            else
            {
                this._thumbBtn.y = param1;
            }
            if (this._content)
            {
                if (this._content.height > this.getlength())
                {
                    this.__thumbBtnMove();
                }
                else
                {
                    this._content.y = 0;
                }
            }
            return;
        }// end function

        private function __upBtnDown(event:Event) : void
        {
            this._direct = this.DIRECT_UP;
            addEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.__stageUp, false, 0, true);
            return;
        }// end function

        private function __downBtnDown(event:Event) : void
        {
            this._direct = this.DIRECT_DOWN;
            addEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.__stageUp, false, 0, true);
            return;
        }// end function

        private function __stageUp(event:Event = null) : void
        {
            this.moveStep = MOVE_STEP_MIN;
            this._direct = this.DIRECT_STOP;
            removeEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.__stageUp);
            return;
        }// end function

        private function __thumbBtnDown(event:Event) : void
        {
            this._thumbBtn.startDrag(false, this.thumbBtnDragRect);
            addEvtListener(Event.ENTER_FRAME, this.__thumbBtnMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.__thumbBtnStop, false, 0, true);
            return;
        }// end function

        private function __thumbBtnStop(event:Event) : void
        {
            this._thumbBtn.stopDrag();
            removeEvtListener(Event.ENTER_FRAME, this.__thumbBtnMove);
            if (stage)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, this.__thumbBtnStop);
            }
            return;
        }// end function

        private function __thumbBtnMove(event:Event = null) : void
        {
            if (this._content.height > this.getlength())
            {
                this._content.y = (this.trackSt * (this.contentTrackLength + this.offsetY) - this._thumbBtn.y * (this.contentTrackLength + this.offsetY)) / (this.trackLength - this._thumbBtn.height);
            }
            else
            {
                this._content.y = 0;
            }
            return;
        }// end function

        private function __enterFrame(event:Event) : void
        {
            this.stepMove();
            return;
        }// end function

        private function stepMove() : void
        {
            if (!this._content)
            {
                return;
            }
            this.moveContent(this._direct, this.moveStep);
            if (this.moveStep < MOVE_STEP_MAX)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.moveStep + 1;
                _loc_1.moveStep = _loc_2;
            }
            this.updateThumbBtnPosition();
            return;
        }// end function

        private function moveContent(param1:int, param2:uint) : void
        {
            if (param1 == this.DIRECT_UP)
            {
                if (this._content.y + param2 < 0)
                {
                    this._content.y = this._content.y + param2;
                }
                else
                {
                    this._content.y = 0;
                }
            }
            else if (param1 == this.DIRECT_DOWN)
            {
                if (this._content.y - param2 > -this.contentTrackLength - this.offsetY)
                {
                    this._content.y = this._content.y - param2;
                }
                else
                {
                    this._content.y = -this.contentTrackLength - this.offsetY;
                }
            }
            return;
        }// end function

        private function updateThumbBtnPosition() : void
        {
            if (this._content)
            {
                this._thumbBtn.y = (this.trackSt * (this.contentTrackLength + this.offsetY) - this._content.y * (this.trackLength - this._thumbBtn.height)) / (this.contentTrackLength + this.offsetY);
            }
            return;
        }// end function

        private function contentMove(param1:uint) : void
        {
            return;
        }// end function

        public function reset() : void
        {
            if (this._content)
            {
                this._content = null;
            }
            return;
        }// end function

        public function get thumbPosition() : int
        {
            if (this._content)
            {
                return this._content.y;
            }
            return 0;
        }// end function

        public function get thumbBtnPosition() : int
        {
            if (this._thumbBtn)
            {
                return this._thumbBtn.y;
            }
            return 0;
        }// end function

    }
}
