package com.game.artifact.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.scroller.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class ArtifactPackGridView extends BaseSprite
    {
        public var itemViews:Vector.<ArtifactPackItemView>;
        private var itemDragKey:String = null;
        private var itemRightClickCallback:Function = null;
        private var itemClickCallback:Function = null;
        private var scrollView:ScrollPanel;
        private var scrollViewContent:Sprite;
        private var columnCount:uint;
        private var columnSep:int;
        private var rowSep:int;
        private var contentX:int;
        private var contentY:int;
        public var items:Vector.<PropInfo>;
        public var visibleWidth:uint;
        public var visibleHeight:uint;
        public var equipTipsClass:Class = null;

        public function ArtifactPackGridView(param1:uint, param2:uint, param3:uint, param4:int, param5:int, param6:int, param7:int)
        {
            this.itemViews = new Vector.<ArtifactPackItemView>;
            this.items = new Vector.<PropInfo>;
            this.columnCount = param3;
            this.columnSep = param4;
            this.rowSep = param5;
            this.contentX = param6;
            this.contentY = param7;
            this.visibleWidth = param1;
            this.visibleHeight = param2;
            this.scrollViewContent = new Sprite();
            this.scrollView = new ScrollPanel(param1, param2);
            this.scrollView.content = this.scrollViewContent;
            addChild(this.scrollView);
            return;
        }// end function

        public function setCellDragKey(param1:String) : void
        {
            var _loc_2:* = null;
            this.itemDragKey = param1;
            for each (_loc_2 in this.itemViews)
            {
                
                _loc_2.setDragKey(this.itemDragKey);
            }
            return;
        }// end function

        public function setCellRightClickCallback(param1:Function) : void
        {
            this.itemRightClickCallback = param1;
            return;
        }// end function

        public function setCellClickCallback(param1:Function) : void
        {
            this.itemClickCallback = param1;
            return;
        }// end function

        public function setData(param1:Vector.<PropInfo>) : void
        {
            var _loc_2:* = 0;
            var _loc_8:* = null;
            var _loc_10:* = null;
            this.items = param1;
            var _loc_3:* = this.contentX;
            var _loc_4:* = this.contentY;
            var _loc_5:* = ArtifactPackItemView.cellWidth + this.columnSep;
            var _loc_6:* = ArtifactPackItemView.cellHeight + this.rowSep;
            var _loc_7:* = 0;
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_10 = param1[_loc_2];
                if (_loc_2 >= this.itemViews.length)
                {
                    _loc_8 = new ArtifactPackItemView(null, this.equipTipsClass);
                    _loc_8.setDragKey(this.itemDragKey);
                    _loc_8.addEventListener("rightClick", this.onCellRightClick);
                    _loc_8.addEventListener(MouseEvent.CLICK, this.onCellClick);
                    this.itemViews.push(_loc_8);
                }
                else
                {
                    _loc_8 = this.itemViews[_loc_2];
                }
                if (!_loc_8.parent)
                {
                    _loc_8.move(_loc_3, _loc_4);
                    this.scrollViewContent.addChild(_loc_8);
                }
                _loc_8.setItem(_loc_10);
                _loc_3 = _loc_3 + _loc_5;
                if (++_loc_7 == this.columnCount)
                {
                    ++_loc_7 = 0;
                    _loc_3 = 0;
                    _loc_4 = _loc_4 + _loc_6;
                }
                _loc_2 = _loc_2 + 1;
            }
            while (_loc_2 < this.itemViews.length)
            {
                
                _loc_8 = this.itemViews[_loc_2];
                if (_loc_8.parent)
                {
                    _loc_8.setItem(null);
                    this.scrollViewContent.removeChild(_loc_8);
                }
                else
                {
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.scrollView.updateThumb();
            var _loc_9:* = this.contentY + this.scrollViewContent.height;
            if (this.contentY + this.scrollViewContent.height <= this.scrollView._h)
            {
                if (this.scrollViewContent.y < 0)
                {
                    this.scrollView.scrollToByContent(0);
                }
            }
            else if (this.scrollViewContent.y < 0)
            {
                if (-this.scrollViewContent.y + this.scrollView._h > _loc_9)
                {
                    this.scrollView.scrollToByContent(_loc_9 - this.scrollView._h);
                }
            }
            return;
        }// end function

        private function onCellRightClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this.itemRightClickCallback != null)
            {
                _loc_2 = event.currentTarget as ArtifactPackItemView;
                if (_loc_2.item != null)
                {
                    this.itemRightClickCallback(_loc_2.item);
                }
            }
            return;
        }// end function

        private function onCellClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this.itemClickCallback != null)
            {
                _loc_2 = event.currentTarget as ArtifactPackItemView;
                if (_loc_2.item != null)
                {
                    this.itemClickCallback(_loc_2.item);
                    event.stopImmediatePropagation();
                }
            }
            return;
        }// end function

        public function getItemViewByItemId(param1:long) : ArtifactPackItemView
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.items.length)
            {
                
                if (this.items[_loc_2].itemId.equal(param1))
                {
                    return this.itemViews[_loc_2];
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

    }
}
