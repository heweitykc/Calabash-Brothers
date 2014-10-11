package com.f1.ui.list
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;

    public class DropList extends Component
    {
        private var _list:List;
        private var _bg:Sprite;
        private var _enable:Boolean = true;
        private var _suspend:Boolean;

        public function DropList(param1 = null, param2:uint = 0, param3:uint = 150, param4 = null)
        {
            if (!param1)
            {
                param1 = new BaseButton("droplist_button1", true);
            }
            if (param1 is String || param1 is DisplayObject)
            {
                param1 = new BaseButton(param1, true);
            }
            super(param1);
            if (param2 == 0)
            {
                param2 = display._w;
            }
            if (param4 == null)
            {
                this._list = new List(param2, param3);
                this._list.autoBgHeight = true;
                this._list.move(0, display._h);
            }
            else
            {
                this._bg = ToolKit.getNew(param4);
                this._bg.width = param2;
                this._bg.height = param3;
                this._bg.y = display._h;
                this._list = new List(param2 - 6, param3 - 6);
                this._list.autoBgHeight = true;
                this._list.move(3, display._h + 3);
            }
            display.mouseEnabled = true;
            display.addEvtListener(MouseEvent.CLICK, this.__clickBtn);
            this._list.addEvtListener(Event.CHANGE, this.__change);
            addEvtListener(MouseEvent.ROLL_OUT, this.__blurOut);
            return;
        }// end function

        public function get enable() : Boolean
        {
            return this._enable;
        }// end function

        private function removeContainer() : void
        {
            if (this._list && this._list.parent)
            {
                this._list.parent.removeChild(this._list);
            }
            if (this._bg && this._bg.parent)
            {
                this._bg.parent.removeChild(this._bg);
            }
            return;
        }// end function

        public function set enable(param1:Boolean) : void
        {
            this._enable = param1;
            if (!this._enable)
            {
                this.removeContainer();
            }
            return;
        }// end function

        public function getViewList() : List
        {
            return this._list;
        }// end function

        public function get suspend() : Boolean
        {
            return this._suspend;
        }// end function

        public function set suspend(param1:Boolean) : void
        {
            this._suspend = param1;
            return;
        }// end function

        public function endSuspend(param1:Boolean) : void
        {
            if (!this._suspend)
            {
                return;
            }
            if (param1)
            {
                if (this._list.selectItem)
                {
                    display.setText(this._list.selectItem.label);
                }
            }
            display.selected = false;
            return;
        }// end function

        private function __clickBtn(event:MouseEvent) : void
        {
            if (!this._enable)
            {
                return;
            }
            if (this._list.parent)
            {
                removeChild(this._list);
                if (this._bg && this._bg.parent)
                {
                    this._bg.parent.removeChild(this._bg);
                }
            }
            else
            {
                if (this._bg)
                {
                    addChild(this._bg);
                }
                addChild(this._list);
            }
            return;
        }// end function

        private function __blurOut(event:MouseEvent = null) : void
        {
            display.selected = false;
            if (this._list.parent)
            {
                removeChild(this._list);
            }
            if (this._bg && this._bg.parent)
            {
                this._bg.parent.removeChild(this._bg);
            }
            return;
        }// end function

        public function setText(param1:String) : void
        {
            display.setText(param1);
            return;
        }// end function

        private function __change(event:Event) : void
        {
            if (!this._suspend)
            {
                if (this._list.selectItem)
                {
                    display.setText(this._list.selectItem.label);
                }
                display.selected = false;
            }
            ToolKit.disappear(this._bg);
            if (this._list.parent)
            {
                removeChild(this._list);
            }
            dispatchEvent(event);
            return;
        }// end function

        public function add(param1:IItem, param2:Boolean = false, param3:int = 0, param4:int = 0) : IItem
        {
            return this._list.add(param1, param2, param3, param4);
        }// end function

        public function scrollToItem(param1:DisplayObject) : void
        {
            this._list.scrollToItem(param1);
            return;
        }// end function

        public function setScrollBarVisible(param1:Boolean) : void
        {
            this._list.scroll.visible = param1;
            return;
        }// end function

        public function set objs(param1:Array) : void
        {
            this._list.objs = param1;
            return;
        }// end function

        public function get objs() : Array
        {
            return this._list.objs;
        }// end function

        public function get itemNum() : int
        {
            return this._list.length;
        }// end function

        public function removeItem(param1:IItem) : void
        {
            this._list.removeItem(param1);
            return;
        }// end function

        public function removeItemAt(param1:int) : void
        {
            this._list.removeItemAt(param1);
            return;
        }// end function

        public function set selectIndex(param1:int) : void
        {
            this._list.selectIndex = param1;
            return;
        }// end function

        public function get selectIndex() : int
        {
            return this._list.selectIndex;
        }// end function

        public function set selectItem(param1:IItem) : void
        {
            this._list.selectItem = param1;
            return;
        }// end function

        public function get selectItem() : IItem
        {
            return this._list.selectItem;
        }// end function

        public function get selectObj()
        {
            return this._list.selectObj;
        }// end function

        public function set selectKey(param1) : void
        {
            this._list.selectKey = param1;
            return;
        }// end function

        public function get cellRenderer() : Class
        {
            return this._list.cellRenderer;
        }// end function

        public function set cellRenderer(param1:Class) : void
        {
            this._list.cellRenderer = param1;
            return;
        }// end function

        public function reset() : void
        {
            this._list.reset();
            return;
        }// end function

        public function set listX(param1:Number) : void
        {
            this._list._x = param1;
            return;
        }// end function

        public function set listY(param1:Number) : void
        {
            this._list._y = param1;
            return;
        }// end function

    }
}
