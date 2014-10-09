package com.game.transactions.view
{
    import com.game.backpack.view.itemrenderers.*;
    import com.game.transactions.events.*;
    import com.manager.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.geom.*;
    import interfaces.*;

    public class TransactionBox extends DragBaseItem
    {
        private var _isMine:Boolean;
        private var _isLocked:Boolean;

        public function TransactionBox(param1:String = "backpackbox_bg")
        {
            super(param1);
            _place = Params.ITEM_PLACE_TRANSCATION;
            _accpetKey = [Params.ITEM_PLACE_BACKPACK];
            _image.x = 2;
            _image.y = 2;
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            mouseChildren = false;
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (this._isMine && DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseIn(this);
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (this._isMine && DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseOut(this);
            }
            return;
        }// end function

        public function get isLocked() : Boolean
        {
            return this._isLocked;
        }// end function

        public function set isLocked(param1:Boolean) : void
        {
            this._isLocked = param1;
            return;
        }// end function

        public function get isMine() : Boolean
        {
            return this._isMine;
        }// end function

        public function set isMine(param1:Boolean) : void
        {
            this._isMine = param1;
            return;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            _info = param1;
            setInfo(_info);
            return;
        }// end function

        override public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            dispatchEvent(new TransactionEvent(TransactionEvent.DRAG_OUT, null, true));
            return;
        }// end function

        override public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            if (param1)
            {
                _info = param1 as PropInfo;
                dispatchEvent(new TransactionEvent(TransactionEvent.DRAG_IN, _info, true));
            }
            return;
        }// end function

        override public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            return acceptKey().indexOf(param1.getKey()) != -1 && this._isMine && !this.isLocked;
        }// end function

    }
}
