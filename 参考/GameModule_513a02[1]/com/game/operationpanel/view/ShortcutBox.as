package com.game.operationpanel.view
{
    import com.f1.utils.*;
    import com.game.backpack.view.itemrenderers.*;
    import com.game.operationpanel.event.*;
    import com.manager.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.*;

    public class ShortcutBox extends Itemrenderer
    {
        private var _canDrag:Boolean = false;
        protected var _isNum:Boolean;
        private var numArea:MovieClip;
        private var _dragTimeId:uint;

        public function ShortcutBox(param1:String = "backpackbox_bg")
        {
            super(param1);
            this.numArea = ToolKit.getNew("skillGridNum");
            this.setImageSize(48, 48);
            _image.setSize(48, 48);
            _countTxt.y = 40;
            setWH(56, 56);
            lockOffsetY = 3;
            lockOffsetX = 2;
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
                this.numArea.x = -2;
                this.numArea.y = -2;
            }
            else if (this.numArea.parent)
            {
                this.numArea.parent.removeChild(this.numArea);
            }
            return;
        }// end function

        override public function setCD(param1:int, param2:int) : void
        {
            if (_cdMask == null)
            {
                _cdMask = new CDMask(_w - 6, _h - 6, true);
                _cdMask.mouseEnabled = false;
            }
            if (_cdMask.parent == null)
            {
                _cdMask.x = 1;
                _cdMask.y = 1;
                addChild(_cdMask);
            }
            _cdMask.setCD(param1, param2);
            return;
        }// end function

        public function setNum(param1:String) : void
        {
            TextField(this.numArea["txt_num"]).text = param1;
            return;
        }// end function

        override public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (param1)
            {
                if (param1 is SkillInfo)
                {
                    _info = param1;
                    _image.move(5, 5);
                    _image.load(_info.iconUrl);
                    _image.setSize(_widthImg, _heightImg);
                    ItemTips.create(this, param1, SkillTips);
                    _countTxt.text = "";
                    if (_lockImg && _lockImg.parent)
                    {
                        _lockImg.parent.removeChild(_lockImg);
                    }
                    addListener();
                }
                else
                {
                    super.setInfo(param1);
                }
            }
            else
            {
                this.clean();
            }
            return;
        }// end function

        override public function dragOut() : void
        {
            _image.alpha = 1;
            filters = [];
            return;
        }// end function

        override protected function __mouseDown(event:MouseEvent) : void
        {
            if (!this._canDrag)
            {
                return;
            }
            if (_info)
            {
                if (_info is SkillInfo)
                {
                    if (UserObj.getInstance().playerInfo.isBecome)
                    {
                        return;
                    }
                    clearTimeout(this._dragTimeId);
                    this._dragTimeId = setTimeout(this.doDrag, 200);
                }
                else
                {
                    super.__mouseDown(event);
                }
            }
            return;
        }// end function

        override protected function __up(event:MouseEvent) : void
        {
            if (_info)
            {
                if (_info is SkillInfo)
                {
                    clearTimeout(this._dragTimeId);
                }
                else
                {
                    super.__up(event);
                }
            }
            return;
        }// end function

        private function doDrag() : void
        {
            var _loc_1:* = null;
            if (this._info)
            {
                _loc_1 = {info:_info, url:_info.iconUrl};
                DragManager.getInstance().doDrag(this, _loc_1, 25, 25);
                _image.alpha = 0.3;
            }
            return;
        }// end function

        override public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            var _loc_4:* = null;
            if (param2 == param3)
            {
                return;
            }
            if (param1)
            {
                if (param1 is PropInfo)
                {
                    super.completeDrag(param1, param2, param3);
                }
                else
                {
                    _loc_4 = new Object();
                    _loc_4.info = param1;
                    _loc_4.item = param2;
                    _loc_4.targetItem = param3;
                    OperationDispatch.dispatch().dispatchEvent(new OperationEvent(OperationEvent.SKILL_BOX_MOVE, _loc_4));
                }
            }
            return;
        }// end function

        override public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            if (_info)
            {
                if (_info is SkillInfo)
                {
                    if (param1)
                    {
                        _image.dispose();
                    }
                    else
                    {
                        OperationDispatch.dispatch().dispatchEvent(new OperationEvent(OperationEvent.SKILL_BOX_REMOVE, this.info));
                    }
                    _image.alpha = 1;
                }
                else
                {
                    super.dragSucc(param1, param2);
                }
            }
            return;
        }// end function

        override protected function __click(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function __rightClick(event:MouseEvent) : void
        {
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

        private function setDrag() : void
        {
            if (this._canDrag)
            {
                addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
                addEvtListener(MouseEvent.MOUSE_UP, this.__up);
            }
            else
            {
                removeEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
                removeEvtListener(MouseEvent.MOUSE_UP, this.__up);
            }
            return;
        }// end function

        public function clean() : void
        {
            _info = null;
            super.setInfo(null);
            ItemTips.dispose(this);
            if (_countTxt)
            {
                _countTxt.text = "";
            }
            if (this._image)
            {
                _image.dispose();
                _image.bitmapData = null;
            }
            this.setCD(0, 100);
            return;
        }// end function

    }
}
