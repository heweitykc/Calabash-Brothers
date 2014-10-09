package com.manager
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.vmc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import interfaces.*;

    public class DragManager extends Object
    {
        private var _bmd:BitmapData;
        private var _startItem:IDragItem;
        private var _curItem:IDragItem;
        private var _image:Image;
        private var _inDrag:Boolean;
        private var _effectImage:VMCView;
        private var _prePoint:Point;
        private var _offsetX:int;
        private var _offsetY:int;
        private var _bmp:Bitmap;
        private var _sp:Sprite;
        private var _info:Object;
        private var _w:int;
        private var _h:int;
        private var _mouseIn:Boolean;
        private static var _instance:DragManager;

        public function DragManager()
        {
            this._image = new Image();
            this._effectImage = new VMCView();
            this._effectImage.auto = true;
            this._effectImage.updatePose("90", true);
            this._effectImage.smoothing = true;
            this._image.smoothing = true;
            this._sp = new Sprite();
            this._sp.mouseEnabled = false;
            this._sp.mouseChildren = false;
            this._sp.addChild(this._image);
            this._sp.addChild(this._effectImage);
            return;
        }// end function

        private function getImageUrl(param1:Object) : String
        {
            return param1.hasOwnProperty("url") ? (param1.url) : ("");
        }// end function

        public function isInDrag() : Boolean
        {
            return this._inDrag;
        }// end function

        public function doDrag(param1:DisplayObject, param2:Object, param3:int, param4:int, param5:int = 0, param6:int = 0) : void
        {
            this.inDrag = true;
            this._startItem = param1 as IDragItem;
            this._info = param2;
            this._w = param5;
            this._h = param6;
            var _loc_7:* = this.getImageUrl(param2);
            if (param2.effectUrl)
            {
                this._effectImage.loadRes(param2.effectUrl, null, true);
                this._effectImage.move(param1.width / 2, param1.height / 2);
                this._effectImage.auto = true;
            }
            else
            {
                this._image.load(_loc_7);
            }
            this._offsetX = param3;
            this._offsetY = param4;
            this._prePoint = param1.localToGlobal(new Point(0, 0));
            this._sp.x = this._prePoint.x;
            this._sp.y = this._prePoint.y;
            Global.popManager.addDargLoayer(this._sp);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_UP, this.__up);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.__move);
            return;
        }// end function

        public function set inDrag(param1:Boolean) : void
        {
            this._inDrag = param1;
            return;
        }// end function

        public function get inDrag() : Boolean
        {
            return this._inDrag;
        }// end function

        public function onMouseIn(param1:IDragItem) : void
        {
            if (!this._mouseIn)
            {
                this._mouseIn = true;
            }
            var _loc_2:* = param1.dragAccept(this._startItem, this._info);
            if (_loc_2)
            {
                if (this._curItem)
                {
                    if (this._curItem != param1)
                    {
                        this._curItem.dragOut();
                        this._curItem = param1;
                        this._curItem.dragEnter();
                    }
                }
                else
                {
                    this._curItem = param1;
                    this._curItem.dragEnter();
                }
            }
            return;
        }// end function

        public function onMouseOut(param1:IDragItem) : void
        {
            if (param1 == this._curItem)
            {
                this._curItem.dragOut();
                this._curItem = null;
            }
            return;
        }// end function

        private function __up(event:MouseEvent) : void
        {
            var _loc_3:* = false;
            if (this._sp.parent)
            {
                this._sp.parent.removeChild(this._sp);
            }
            this.inDrag = false;
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_UP, this.__up);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.__move);
            var _loc_2:* = this._sp.localToGlobal(new Point(this._sp.width >> 1, this._sp.height >> 1));
            if (this._curItem)
            {
                _loc_3 = this._curItem.dragAccept(this._startItem, this._info);
                if (_loc_3)
                {
                    this._startItem.dragSucc(true);
                    this._curItem.completeDrag(this._info, this._startItem, this._curItem);
                }
                else
                {
                    this._startItem.dragSucc(false, _loc_2);
                }
                this._startItem = null;
                this._curItem.dragOut();
            }
            else
            {
                this._startItem.dragSucc(false, _loc_2);
            }
            this._image.dispose();
            this._effectImage.finalize();
            if (this._mouseIn)
            {
                this._mouseIn = false;
            }
            return;
        }// end function

        private function __imageComplete(param1:BitmapData) : void
        {
            this._image.width = this._w;
            this._image.height = this._h;
            return;
        }// end function

        private function __move(event:MouseEvent) : void
        {
            var _loc_7:* = null;
            var _loc_2:* = new Point(event.stageX, event.stageY);
            _loc_2.x = _loc_2.x - this._offsetX;
            _loc_2.y = _loc_2.y - this._offsetY;
            this._sp.x = _loc_2.x;
            this._sp.y = _loc_2.y;
            if (this._mouseIn)
            {
                return;
            }
            var _loc_3:* = FrameworkGlobal.stage.getObjectsUnderPoint(new Point(event.stageX, event.stageY));
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = false;
            var _loc_6:* = _loc_3.length - 1;
            while (_loc_6 >= 0)
            {
                
                if (!(_loc_3[_loc_6].parent is IDragItem))
                {
                }
                else
                {
                    _loc_7 = _loc_3[_loc_6].parent as IDragItem;
                    if (_loc_7 && _loc_7.dragAccept(this._startItem, this._info))
                    {
                        if (_loc_7 == this._startItem)
                        {
                        }
                        else if (this._curItem)
                        {
                            if (this._curItem != _loc_7)
                            {
                                this._curItem.dragOut();
                                this._curItem = _loc_7;
                                this._curItem.dragEnter();
                            }
                            _loc_5 = true;
                        }
                        else
                        {
                            this._curItem = _loc_7;
                            this._curItem.dragEnter();
                            _loc_5 = true;
                        }
                    }
                }
                _loc_6 = _loc_6 - 1;
            }
            if (!_loc_5)
            {
                if (this._curItem)
                {
                    this._curItem.dragOut();
                    this._curItem = null;
                }
            }
            return;
        }// end function

        public static function getInstance() : DragManager
        {
            var _loc_1:* = new DragManager;
            _instance = new DragManager;
            return _instance || _loc_1;
        }// end function

    }
}
