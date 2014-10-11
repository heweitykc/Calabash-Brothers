package com.game.chat.view
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class ChatScroller extends Component
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
        private var _content:TextField;
        private var trackSt:uint;
        private var trackLength:uint;
        private var contentTrackLength:uint;
        private var thumbBtnDragRect:Rectangle;
        private var _offsetY:int;
        private var _isTrueThumbH:Boolean = true;
        private var _pageSize:int = 10;
        private var _orgin:int;
        private var _inOperating:Boolean;
        private static const MOVE_STEP_MIN:uint = 8;
        private static const MOVE_STEP_MAX:uint = 14;

        public function ChatScroller(param1:uint, param2:uint, param3:String = "scrollBar1", param4:String = null)
        {
            this.scrollBar = ToolKit.getNew(param3);
            this.initUI();
            this.setWH(param1, param2);
            var _loc_5:* = ToolKit.creatRect(0, 0, param1, param2);
            JSTools.addWheelListener(this.__jsMouseWheeled);
            super(null, param4);
            return;
        }// end function

        public function get inOperating() : Boolean
        {
            return this._inOperating;
        }// end function

        public function get offsetY() : int
        {
            return this._offsetY;
        }// end function

        public function set offsetY(param1:int) : void
        {
            this._offsetY = param1;
            return;
        }// end function

        public function get content() : TextField
        {
            return this._content;
        }// end function

        public function set content(param1:TextField) : void
        {
            this._content = param1;
            if (this._content)
            {
                this._content.addEventListener(MouseEvent.MOUSE_WHEEL, this.__wheel);
            }
            this.updateThumb();
            return;
        }// end function

        public function get scroll() : DisplayObjectContainer
        {
            return this.scrollBar;
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

        public function __wheel(event:MouseEvent) : void
        {
            if (this._content && this._content.maxScrollV > 1)
            {
                this.mouseWheeled(event.delta / 3);
            }
            return;
        }// end function

        public function wheel(param1:int) : void
        {
            if (this._content && this._content.maxScrollV > 1)
            {
                this.mouseWheeled(param1 / 3);
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
            this.moveStep = MOVE_STEP_MAX;
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
            this.setLength(param2);
            return;
        }// end function

        public function setLength(param1:uint) : void
        {
            _h = param1;
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
            var _loc_2:* = 0;
            if (this._content)
            {
                if (this._content.maxScrollV > 1)
                {
                    _loc_1 = (this._content.maxScrollV - 1) + this._pageSize;
                    _loc_2 = Math.max(13, this._pageSize / _loc_1 * this.trackLength);
                    if (this._carve)
                    {
                        if (_loc_2 > this._carve.height + 4)
                        {
                            this._isTrueThumbH = true;
                            this._thumbBtn.setHeight(_loc_2);
                        }
                        else
                        {
                            this._isTrueThumbH = false;
                            _loc_2 = this._carve.height + 4;
                            this._thumbBtn.setHeight(_loc_2);
                        }
                        this._carve.y = uint(_loc_2 / 2 - this._carve.height / 2);
                    }
                    else
                    {
                        this._isTrueThumbH = true;
                        this._thumbBtn.setHeight(_loc_2);
                    }
                    this.thumbBtnDragRect = new Rectangle((this._trackMC.width - this._thumbBtn.width) / 2, this.trackSt, 0, this.trackLength - this._thumbBtn.height);
                    this.updateThumbBtnPosition();
                    this.enableBar();
                }
                else
                {
                    this.contentTrackLength = 0;
                    this.unEnableBar();
                }
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
            this.updateThumbBtnPosition();
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
            return;
        }// end function

        private function __upBtnDown(event:Event) : void
        {
            this._direct = this.DIRECT_UP;
            this._orgin = this._content.scrollV;
            this._inOperating = true;
            addEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.__stageUp, false, 0, true);
            return;
        }// end function

        private function __downBtnDown(event:Event) : void
        {
            this._direct = this.DIRECT_DOWN;
            this._orgin = this._content.scrollV;
            this._inOperating = true;
            addEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.__stageUp, false, 0, true);
            return;
        }// end function

        private function __stageUp(event:Event = null) : void
        {
            this.moveStep = MOVE_STEP_MIN;
            if (this._content.scrollV == this._orgin)
            {
                if (this._direct == this.DIRECT_DOWN)
                {
                    var _loc_2:* = this._content;
                    var _loc_3:* = _loc_2.scrollV + 1;
                    _loc_2.scrollV = _loc_3;
                    _loc_2.scrollV = Math.max(0, Math.min(_loc_2.scrollV, _loc_2.maxScrollV));
                }
                else if (this._direct == this.DIRECT_UP)
                {
                    var _loc_2:* = this._content;
                    var _loc_3:* = _loc_2.scrollV - 1;
                    _loc_2.scrollV = _loc_3;
                    _loc_2.scrollV = Math.max(0, Math.min(_loc_2.scrollV, _loc_2.maxScrollV));
                }
                this.updateThumbBtnPosition();
            }
            this._direct = this.DIRECT_STOP;
            this._inOperating = false;
            removeEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.__stageUp);
            return;
        }// end function

        private function __thumbBtnDown(event:Event) : void
        {
            this._thumbBtn.startDrag(false, this.thumbBtnDragRect);
            this._inOperating = true;
            addEvtListener(Event.ENTER_FRAME, this.__thumbBtnMove);
            if (stage)
            {
                stage.addEventListener(MouseEvent.MOUSE_UP, this.__thumbBtnStop, false, 0, true);
            }
            return;
        }// end function

        private function __thumbBtnStop(event:Event) : void
        {
            this._thumbBtn.stopDrag();
            this._inOperating = false;
            this.__thumbBtnMove();
            removeEvtListener(Event.ENTER_FRAME, this.__thumbBtnMove);
            if (stage)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, this.__thumbBtnStop);
            }
            return;
        }// end function

        private function __thumbBtnMove(event:Event = null) : void
        {
            if (this._content.maxScrollV > 1)
            {
                this._content.scrollV = (this._thumbBtn.y - this.trackSt) / (this.trackLength - this._thumbBtn.height) * (this._content.maxScrollV - 1) + 1;
            }
            else
            {
                this._content.scrollV = 1;
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
            this.moveContent(this._direct, this.moveStep / MOVE_STEP_MAX);
            if (this.moveStep < MOVE_STEP_MAX)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.moveStep + 1;
                _loc_1.moveStep = _loc_2;
            }
            else
            {
                this.moveStep = MOVE_STEP_MIN;
            }
            this.updateThumbBtnPosition();
            return;
        }// end function

        private function moveContent(param1:int, param2:uint) : void
        {
            if (param1 == this.DIRECT_UP)
            {
                if (param2 == 1)
                {
                    var _loc_3:* = this._content;
                    var _loc_4:* = _loc_3.scrollV - 1;
                    _loc_3.scrollV = _loc_4;
                    _loc_3.scrollV = Math.max(0, Math.min(_loc_3.scrollV, _loc_3.maxScrollV));
                }
            }
            else if (param1 == this.DIRECT_DOWN)
            {
                if (param2 == 1)
                {
                    var _loc_3:* = this._content;
                    var _loc_4:* = _loc_3.scrollV + 1;
                    _loc_3.scrollV = _loc_4;
                    _loc_3.scrollV = Math.max(0, Math.min(_loc_3.scrollV, _loc_3.maxScrollV));
                }
            }
            return;
        }// end function

        private function updateThumbBtnPosition() : void
        {
            var _loc_1:* = NaN;
            if (this._content)
            {
                _loc_1 = (this._content.scrollV - 1) / (this._content.maxScrollV - 1);
                if (_loc_1 < 0)
                {
                    _loc_1 = 0;
                }
                this._thumbBtn.y = this.trackSt + _loc_1 * (this.trackLength - this._thumbBtn.height);
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

    }
}
