package com.game.operationpanel.view
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.game.operationpanel.event.*;
    import com.manager.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.*;

    public class SkillBox extends BaseSprite implements IDragItem
    {
        private var _canDrag:Boolean = false;
        private var _info:SkillInfo;
        private var _id:int;
        protected var _cd:CDMask;
        protected var _image:Image;
        protected var _widthImg:int = 48;
        protected var _heightImg:int = 48;
        protected var _isNum:Boolean;
        protected var _place:String;
        protected var backBmp:Bitmap;
        protected var numArea:MovieClip;
        protected var _txt:TextField;
        private var _dragTimeId:uint;

        public function SkillBox(param1:String)
        {
            this.backBmp = ToolKit.getNewDO(param1) as Bitmap;
            this.addChild(this.backBmp);
            this.setChildIndex(this.backBmp, 0);
            buttonMode = true;
            this._image = new Image();
            this._image.move(5, 5);
            this._image.setSize(this._widthImg, this._heightImg);
            addChild(this._image);
            this._cd = new CDMask(56, 56);
            addChild(this._cd);
            this.numArea = ToolKit.getNew("skillGridNum");
            this.mouseChildren = false;
            return;
        }// end function

        public function get isNum() : Boolean
        {
            return this._isNum;
        }// end function

        public function set isNum(param1:Boolean) : void
        {
            this._isNum = param1;
            if (param1)
            {
                this.addChild(this.numArea);
            }
            else if (this.numArea && this.numArea.parent)
            {
                this.numArea.parent.removeChild(this.numArea);
            }
            return;
        }// end function

        public function get canDrag() : Boolean
        {
            return this._canDrag;
        }// end function

        public function set canDrag(param1:Boolean) : void
        {
            this._canDrag = param1;
            this.setDrag();
            return;
        }// end function

        public function get place() : String
        {
            return this._place;
        }// end function

        public function set place(param1:String) : void
        {
            this._place = param1;
            return;
        }// end function

        public function get info() : SkillInfo
        {
            return this._info;
        }// end function

        public function set info(param1:SkillInfo) : void
        {
            if (this._info != param1)
            {
                this._info = param1;
                this._cd.setCD(0, 0);
                this.setInfo();
            }
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function setImageSize(param1:int, param2:int) : void
        {
            this._widthImg = param1;
            this._heightImg = param2;
            return;
        }// end function

        public function setCD(param1:int, param2:int) : void
        {
            this._cd.setCD(param1, param2);
            return;
        }// end function

        public function setNum(param1:int) : void
        {
            TextField(this.numArea["txt_num"]).text = param1.toString();
            return;
        }// end function

        private function setDrag() : void
        {
            if (this._canDrag)
            {
                addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
                addEvtListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            }
            else
            {
                removeEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
                removeEvtListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            }
            return;
        }// end function

        private function setInfo() : void
        {
            if (this._info)
            {
                this._image.load(this._info.iconUrl);
                this._image.setSize(this._widthImg, this._heightImg);
                ItemTips.create(this, this._info, SkillTips);
            }
            else
            {
                ItemTips.dispose(this);
            }
            return;
        }// end function

        private function __mouseDown(event:MouseEvent) : void
        {
            if (UserObj.getInstance().playerInfo.isBecome)
            {
                return;
            }
            clearTimeout(this._dragTimeId);
            this._dragTimeId = setTimeout(this.doDrag, 200);
            return;
        }// end function

        private function doDrag() : void
        {
            var _loc_1:* = null;
            if (this._info)
            {
                _loc_1 = {info:this._info, url:this._info.iconUrl};
                DragManager.getInstance().doDrag(this, _loc_1, 25, 25);
                this._image.alpha = 0.3;
            }
            return;
        }// end function

        private function __mouseUp(event:MouseEvent) : void
        {
            clearTimeout(this._dragTimeId);
            return;
        }// end function

        public function dragEnter() : void
        {
            this._image.alpha = 0.3;
            return;
        }// end function

        public function dragOut() : void
        {
            this._image.alpha = 1;
            return;
        }// end function

        public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            if (param2 == param3)
            {
                return;
            }
            var _loc_4:* = new Object();
            _loc_4.info = param1;
            _loc_4.item = param2;
            _loc_4.targetItem = param3;
            OperationDispatch.dispatch().dispatchEvent(new OperationEvent(OperationEvent.SKILL_BOX_MOVE, _loc_4));
            return;
        }// end function

        public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            if (param1)
            {
                this._image.dispose();
            }
            else
            {
                OperationDispatch.dispatch().dispatchEvent(new OperationEvent(OperationEvent.SKILL_BOX_REMOVE, this.info));
            }
            this._image.alpha = 1;
            return;
        }// end function

        public function acceptKey() : Array
        {
            return ["skill", Params.ITEM_PLACE_BACKPACK];
        }// end function

        public function getKey() : String
        {
            var _loc_1:* = "skill";
            this._place = "skill";
            return _loc_1;
        }// end function

        public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            var _loc_3:* = this.getKey() == param1.getKey();
            return _loc_3;
        }// end function

        public function clean() : void
        {
            this.info = null;
            if (this._image)
            {
                this._image.dispose();
                this._image.bitmapData = null;
            }
            this.setCD(0, 100);
            return;
        }// end function

    }
}
