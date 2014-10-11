package com.f1.ui.tree
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TreeItem extends Component implements IItem
    {
        private var container:Sprite;
        private var totalHeight:Number = 0;
        private var ySpace:Number = 1;
        private var _unfold:Boolean = false;
        public var oldTit:String = "";
        protected var _obj:Object;
        private var rectShowHideMC:DisplayObjectContainer;
        private var txt:TextField;
        private var txt2:TextField;
        private var cover:MovieClip;
        private var btn:MovieClip;
        private var bg:MovieClip;
        private var btnBg:BaseButton;
        private var _empty:Boolean = true;
        private var _isBtn:Boolean = true;

        public function TreeItem(param1:String, param2:uint = 16773804, param3:String = null, param4:uint = 6737151, param5:Boolean = true)
        {
            this.container = new Sprite();
            this._isBtn = param5;
            this.rectShowHideMC = ToolKit.getNew("RectShowHideMC");
            initComponentUI(this.rectShowHideMC);
            this.initUI();
            this.addEvents();
            this.init(param1, param2, param3, param4);
            return;
        }// end function

        public function get key()
        {
            return this.txt.text;
        }// end function

        public function get label() : String
        {
            return this.txt.text;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public function set obj(param1) : void
        {
            this._obj = param1;
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this.btn.currentFrame == 2;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this.setSelected(param1);
            return;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

        public function get isUnfold() : Boolean
        {
            return this._unfold;
        }// end function

        public function get contain() : Sprite
        {
            return this.container;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt = this.rectShowHideMC.getChildByName("txt") as TextField;
            this.txt.mouseEnabled = false;
            this.txt2 = this.rectShowHideMC.getChildByName("txt2") as TextField;
            this.txt2.mouseEnabled = false;
            this.cover = this.rectShowHideMC.getChildByName("cover") as MovieClip;
            this.cover.mouseEnabled = false;
            this.btn = this.rectShowHideMC.getChildByName("btn") as MovieClip;
            this.btn.visible = false;
            this.bg = this.rectShowHideMC.getChildByName("bg") as MovieClip;
            if (this._isBtn)
            {
                this.btnBg = new BaseButton(this.bg);
            }
            return;
        }// end function

        private function addEvents() : void
        {
            return;
        }// end function

        public function init(param1:String, param2:uint = 16773804, param3:String = null, param4:uint = 6737151) : void
        {
            this.oldTit = param1;
            this.changeTitle(param1, param2);
            if (param3 == null)
            {
                this.txt2.parent.removeChild(this.txt2);
            }
            else
            {
                this.txt2.textColor = param4;
                this.txt2.text = param3;
                this.txt2.x = this.txt2.x - 10;
            }
            this.container.y = this.btn.parent.height;
            this.cover.buttonMode = true;
            this.btn.addEventListener(MouseEvent.CLICK, this.clickHandler);
            if (this.btnBg)
            {
                this.btnBg.addEventListener(MouseEvent.CLICK, this.clickHandler);
            }
            else
            {
                this.bg.addEventListener(MouseEvent.CLICK, this.clickHandler);
            }
            this.unfold();
            return;
        }// end function

        public function changeTitle(param1:String, param2:uint = 16773804) : void
        {
            this.txt.textColor = param2;
            this.txt.text = param1;
            return;
        }// end function

        public function clickHandler(event:MouseEvent = null) : void
        {
            if (this._empty)
            {
                return;
            }
            if (this.btn.currentFrame == 1)
            {
                this.unfold();
            }
            else
            {
                this.fold();
            }
            return;
        }// end function

        public function setTreeItemBgWidth(param1:int) : void
        {
            if (this.bg)
            {
                this.bg.width = param1;
            }
            return;
        }// end function

        public function directFold() : void
        {
            this.unfold();
            return;
        }// end function

        public function directUnFold() : void
        {
            this.fold();
            return;
        }// end function

        public function addItem(param1:DisplayObject) : void
        {
            param1.y = this.totalHeight;
            this.container.addChild(param1);
            this.totalHeight = this.totalHeight + (param1.height + this.ySpace);
            if (this._empty)
            {
                this._empty = false;
                this.btn.visible = true;
                this.fold();
            }
            return;
        }// end function

        public function addItemAt(param1:DisplayObject, param2:uint) : void
        {
            param1.y = this.totalHeight;
            this.container.addChildAt(param1, param2);
            this.totalHeight = this.totalHeight + (param1.height + this.ySpace);
            return;
        }// end function

        public function getItemAt(param1:int) : DisplayObject
        {
            if (param1 < this.container.numChildren)
            {
                return this.container.getChildAt(param1);
            }
            return null;
        }// end function

        public function setItemIndex(param1:DisplayObject, param2:int) : void
        {
            if (param1 && param1.parent == this.container)
            {
                if (param2 < this.container.numChildren)
                {
                    this.container.setChildIndex(param1, param2);
                }
            }
            return;
        }// end function

        public function unfold() : void
        {
            this.btn.gotoAndStop(2);
            this.addChild(this.container);
            this._unfold = false;
            setWH(this.width, this.height);
            dispatchEvent(new Event(Event.CHANGE, true));
            return;
        }// end function

        public function fold() : void
        {
            this.btn.gotoAndStop(1);
            if (this.contains(this.container))
            {
                this.removeChild(this.container);
            }
            this._unfold = true;
            setWH(this.width, this.height);
            dispatchEvent(new Event(Event.CHANGE, true));
            return;
        }// end function

        public function getItemNum() : int
        {
            return this.container.numChildren;
        }// end function

        public function removeAllItems() : void
        {
            ToolKit.clearMcChild(this.container);
            this.totalHeight = 0;
            return;
        }// end function

        public function removeItem(param1:DisplayObject) : void
        {
            if (param1 && param1.parent == this.container)
            {
                this.container.removeChild(param1);
                this.totalHeight = this.totalHeight - param1.height;
            }
            return;
        }// end function

        public function rangeNow() : void
        {
            this.totalHeight = 0;
            var _loc_1:* = 0;
            while (_loc_1 < this.getItemNum())
            {
                
                this.getItemAt(_loc_1).y = this.totalHeight;
                this.totalHeight = this.totalHeight + this.getItemAt(_loc_1).height;
                _loc_1++;
            }
            return;
        }// end function

        override public function finalize() : void
        {
            this.removeAllItems();
            super.finalize();
            return;
        }// end function

    }
}
