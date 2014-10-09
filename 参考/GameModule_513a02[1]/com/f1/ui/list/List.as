package com.f1.ui.list
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import flash.display.*;
    import flash.events.*;

    public class List extends ScrollPanel implements IList
    {
        protected var _cellRenderer:Class;
        protected var _selectItem:IItem;
        protected var _box:HBox;
        protected var _selectIndex:int = -1;
        public var selectable:Boolean = false;
        public var mutiSelect:Boolean = false;
        private var _objs:Array;
        private var _cellH:int;
        private var _cellWidth:int;

        public function List(param1:uint = 100, param2:uint = 200, param3:String = null, param4:String = "scrollBar1")
        {
            this._cellRenderer = SimpleItem;
            super(param1, param2, param4, param3);
            this._box = new HBox();
            var _loc_5:* = 0;
            this._box.intervalY = 0;
            this._box.intervalX = _loc_5;
            content = this._box;
            return;
        }// end function

        public function get cellRenderer() : Class
        {
            return this._cellRenderer;
        }// end function

        public function set cellRenderer(param1:Class) : void
        {
            this._cellRenderer = param1;
            return;
        }// end function

        public function get cellH() : int
        {
            return this._cellH;
        }// end function

        public function initCellH() : void
        {
            var _loc_1:* = new this._cellRenderer();
            this._cellH = _loc_1._h;
            return;
        }// end function

        public function set objs(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            if (!this._cellRenderer)
            {
                return;
            }
            this.reset();
            this._objs = param1;
            for each (_loc_4 in param1)
            {
                
                if (_loc_4)
                {
                    _loc_2 = new this._cellRenderer();
                    if (this.oneRow == 1)
                    {
                        _loc_2.setWidth(_w);
                    }
                    _loc_2.obj = _loc_4;
                    _loc_2.addEvtListener(MouseEvent.CLICK, this.__clickItem);
                    this._box.add(_loc_2);
                }
            }
            updateThumb();
            return;
        }// end function

        public function get objs() : Array
        {
            return this._objs;
        }// end function

        public function addObj(param1) : IItem
        {
            var _loc_2:* = new this._cellRenderer();
            if (this._cellWidth)
            {
                _loc_2.setWidth(this._cellWidth);
            }
            _loc_2.obj = param1;
            this.add(_loc_2);
            return _loc_2;
        }// end function

        public function add(param1:IItem, param2:Boolean = false, param3:int = 0, param4:int = 0) : IItem
        {
            if (this.oneRow == 1)
            {
                param1.setWidth(_w);
            }
            this._box.add(param1, param2, param3, param4);
            param1.addEvtListener(MouseEvent.CLICK, this.__clickItem);
            updateThumb();
            return param1;
        }// end function

        public function addAt(param1:IItem, param2:uint, param3:Boolean = false, param4:int = 0, param5:int = 0) : IItem
        {
            if (this.oneRow == 1)
            {
                param1.setWidth(_w);
            }
            this._box.addAt(param1, param2, param3, param4, param5);
            param1.addEvtListener(MouseEvent.CLICK, this.__clickItem);
            updateThumb();
            return param1;
        }// end function

        public function get length() : uint
        {
            return this._box.size;
        }// end function

        public function get contents() : Array
        {
            return this._box.contents;
        }// end function

        public function set oneRow(param1:uint) : void
        {
            this._box.oneRow = param1;
            return;
        }// end function

        public function get oneRow() : uint
        {
            return this._box.oneRow;
        }// end function

        public function get selectIndex() : int
        {
            return this._selectIndex;
        }// end function

        public function set selectIndex(param1:int) : void
        {
            this._selectIndex = param1;
            if (this._selectIndex == -1)
            {
                this._selectItem = null;
            }
            else
            {
                this._selectItem = this.contents[this._selectIndex];
            }
            this.selectingItem(this._selectItem);
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get selectItem() : IItem
        {
            return this._selectItem;
        }// end function

        public function set selectItem(param1:IItem) : void
        {
            this._selectItem = param1;
            if (this._selectItem)
            {
                this._selectIndex = this.contents.indexOf(this._selectItem);
            }
            else
            {
                this._selectIndex = -1;
            }
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get selectKey()
        {
            if (this._selectItem)
            {
                return this._selectItem.key;
            }
            return null;
        }// end function

        public function set selectKey(param1) : void
        {
            this.selectItem = this.getItemByKey(param1);
            return;
        }// end function

        public function get selectObj()
        {
            if (this._selectItem)
            {
                return this._selectItem.obj;
            }
            return null;
        }// end function

        public function getItemByKey(param1) : IItem
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.contents)
            {
                
                if (_loc_2.key == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function removeItem(param1:IItem) : void
        {
            if (!param1)
            {
                return;
            }
            if (this._selectItem == param1)
            {
                this.selectItem = null;
            }
            this._box.remove(param1);
            updateThumb();
            return;
        }// end function

        public function removeItemAt(param1:int) : void
        {
            if (this._selectIndex == param1)
            {
                this.selectIndex = -1;
            }
            this._box.removeByIndex(param1);
            updateThumb();
            return;
        }// end function

        public function removeItemByKey(param1) : void
        {
            var _loc_2:* = this.getItemByKey(param1);
            this.removeItem(_loc_2);
            return;
        }// end function

        private function __clickItem(event:MouseEvent) : void
        {
            this.selectItem = event.currentTarget as IItem;
            this.selectingItem(this.selectItem);
            return;
        }// end function

        private function selectingItem(param1:IItem) : void
        {
            var _loc_2:* = null;
            if (this.selectable)
            {
                if (!this.mutiSelect)
                {
                    for each (_loc_2 in this._box.contents)
                    {
                        
                        if (_loc_2 != this.selectItem && _loc_2.selected)
                        {
                            _loc_2.setSelected(false, false);
                        }
                    }
                }
                this.selectItem.setSelected(true);
            }
            return;
        }// end function

        public function set intervalX(param1:Number) : void
        {
            this._box.intervalX = param1;
            return;
        }// end function

        public function set intervalY(param1:Number) : void
        {
            this._box.intervalY = param1;
            return;
        }// end function

        public function get intervalX() : Number
        {
            return this._box.intervalX;
        }// end function

        public function get intervalY() : Number
        {
            return this._box.intervalY;
        }// end function

        override public function reset() : void
        {
            this._box.reset(true);
            this._selectItem = null;
            this._selectIndex = -1;
            updateThumb();
            return;
        }// end function

        public function update() : void
        {
            this._box.update();
            updateThumb();
            return;
        }// end function

        public function scrollToItem(param1:DisplayObject) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param1)
            {
                _loc_2 = Math.ceil(_h / (param1.height + this.intervalY));
                _loc_3 = int(_loc_2 / 2);
                _loc_4 = _loc_2 % 2 == 0 ? (true) : (false);
                _loc_5 = this.contents.indexOf(param1);
                _loc_6 = 0;
                if (_loc_4)
                {
                    if (_loc_5 < _loc_3)
                    {
                        _loc_6 = 0;
                    }
                    else
                    {
                        _loc_6 = this.getContent(_loc_5 - _loc_3).y;
                    }
                }
                else if (_loc_5 <= _loc_3)
                {
                    _loc_6 = 0;
                }
                else
                {
                    _loc_6 = this.getContent(_loc_5 - _loc_3 + 1).y;
                }
                if (this._box.height - param1.y > _h)
                {
                    scrollToByContent(_loc_6);
                }
                else
                {
                    scrollToBottom();
                }
            }
            return;
        }// end function

        public function getContent(param1:uint)
        {
            if (param1 > (this.contents.length - 1))
            {
                return null;
            }
            return this.contents[param1];
        }// end function

        public function search(param1, param2) : IItem
        {
            var _loc_4:* = null;
            var _loc_3:* = this._box.contents;
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4.obj[param1] == param2)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

    }
}
