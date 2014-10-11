package com.game.artifact.view
{
    import com.game.backpack.view.itemrenderers.*;
    import com.game.utils.*;
    import com.manager.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import interfaces.*;

    public class ArtifactPackItemView extends DragBaseItem
    {
        public var item:PropInfo;
        private var itemId:long;
        public static const DRAG_KEY_EXTRACT:String = "ArtifactExtractPackItem";
        public static var cellWidth:uint = 48;
        public static var cellHeight:uint = 48;

        public function ArtifactPackItemView(param1:DisplayObject = null, param2:Class = null)
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            super("commonRewardBox2_40");
            _image.move(4, 4);
            if (param2 != null)
            {
                this.equipTipsClass = param2;
            }
            addEvtListener(MouseEvent.MOUSE_DOWN, __mouseDown);
            if (param1 != null)
            {
                _loc_3 = param1.parent;
                _loc_4 = _loc_3.getChildIndex(param1);
                move(param1.x, param1.y);
                _loc_3.removeChild(param1);
                _loc_3.addChildAt(this, _loc_4);
            }
            return;
        }// end function

        public function setItem(param1:PropInfo) : void
        {
            var _loc_2:* = this.itemId;
            this.item = param1;
            this.itemId = param1 == null ? (null) : (param1.itemId);
            setInfo(param1);
            if (param1 == null || _loc_2 == null || !_loc_2.equal(param1.itemId))
            {
                __up(null);
            }
            return;
        }// end function

        public function setDragKey(param1:String) : void
        {
            _place = param1;
            return;
        }// end function

        override protected function __doDrag(event:MouseEvent) : void
        {
            if (getKey() == null || this.item == null || DragManager.getInstance().inDrag)
            {
                return;
            }
            super.__doDrag(event);
            return;
        }// end function

        override public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            return false;
        }// end function

        override public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            _image.alpha = 1;
            return;
        }// end function

    }
}
