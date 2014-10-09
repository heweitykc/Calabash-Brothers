package com.game.magicbook.view
{
    import __AS3__.vec.*;
    import com.events.ui.*;
    import com.f1.ui.*;
    import com.f1.ui.list.*;
    import com.game.magicbook.control.*;
    import com.game.magicbook.model.*;
    import com.game.magicbook.view.compent.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class MagicBookGrowView extends Component
    {
        private var _titleTxt:TextField;
        private var _itemList:List;
        private var _magicBookInfo:MagicBookInfo;
        public static var magicBookLang:String = MagicBookControl.MAGICBOOK_LANG;

        public function MagicBookGrowView()
        {
            this._magicBookInfo = MagicBookData.getMagicBookInfo();
            initComponentUI("magicBook_growView");
            this.move(390, 90);
            this.initUI();
            this.addEvent();
            return;
        }// end function

        private function initUI() : void
        {
            this._itemList = new List(330, 400);
            this._itemList.intervalY = -8;
            this._itemList.move(8, 8);
            addChild(this._itemList);
            this._itemList.cellRenderer = MagicBookToolsItem;
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function __updateInfo(event:MagicBookEvent = null) : void
        {
            return;
        }// end function

        private function __tabChange(event:Event) : void
        {
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            MagicBookControl.getIntance().reqUseOnce();
            this._magicBookInfo.addEvtListener(MagicBookEvent.USEITEM_CHANGE, this.__updateItem);
            return;
        }// end function

        private function __updateItem(event:MagicBookEvent) : void
        {
            var _loc_2:* = this._magicBookInfo.useOnces;
            var _loc_3:* = new Array();
            var _loc_4:* = _loc_2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3.push(_loc_2[_loc_5]);
                _loc_5++;
            }
            this._itemList.objs = _loc_3;
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this._magicBookInfo.removeEvtListener(MagicBookEvent.USEITEM_CHANGE, this.__updateItem);
            return;
        }// end function

    }
}
