package com.game.backpack.view.itemrenderers
{
    import com.f1.*;
    import com.manager.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.geom.*;
    import interfaces.*;

    public class DragBaseItem extends IconItem implements IDragItem
    {
        protected var _accpetKey:Array;

        public function DragBaseItem(param1:String = "backpackbox_bg")
        {
            super(param1);
            return;
        }// end function

        public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            return;
        }// end function

        public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            return;
        }// end function

        protected function __mouseDown(event:MouseEvent) : void
        {
            addEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            addEvtListener(MouseEvent.MOUSE_UP, this.__up);
            addEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            return;
        }// end function

        private function __rollout(event:MouseEvent) : void
        {
            removeEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            removeEvtListener(MouseEvent.MOUSE_UP, this.__up);
            removeEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            return;
        }// end function

        protected function __up(event:MouseEvent) : void
        {
            removeEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            removeEvtListener(MouseEvent.MOUSE_UP, this.__up);
            removeEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            return;
        }// end function

        protected function __doDrag(event:MouseEvent) : void
        {
            removeEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            removeEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            DragManager.getInstance().doDrag(this, _info, event.localX, event.localY, 40, 40);
            _image.alpha = 0.3;
            return;
        }// end function

        public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            if (!visible)
            {
                return false;
            }
            return this.acceptKey().indexOf(param1.getKey()) != -1;
        }// end function

        public function dragEnter() : void
        {
            filters = this.filters.concat(FrameworkGlobal.ORANGE_FILTER);
            _image.alpha = 0.3;
            return;
        }// end function

        public function dragOut() : void
        {
            filters = [];
            _image.alpha = 1;
            return;
        }// end function

        public function getKey() : String
        {
            return _place;
        }// end function

        public function acceptKey() : Array
        {
            return this._accpetKey;
        }// end function

    }
}
