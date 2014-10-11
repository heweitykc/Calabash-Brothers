package com.game.newactivity.mayactivity.view
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.newactivity.mayactivity.view.*;
    import com.game.newactivity.message.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class MayArchangelComingView extends Component implements IMayActView
    {
        private var nameDic:Dictionary;
        private var markDic:Dictionary;
        private var iconDic:Dictionary;
        private var tips:Sprite;
        private var tipText:TextField;

        public function MayArchangelComingView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            initComponentUI(param1);
            this.displayReady();
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            this.initUI();
            this.addEvent();
            return;
        }// end function

        private function initUI() : void
        {
            this.nameDic = new Dictionary();
            this.markDic = new Dictionary();
            var _loc_1:* = 1;
            _loc_1 = 1;
            while (_loc_1 <= 3)
            {
                
                this.nameDic[_loc_1] = getDisplayChildByName("name_" + _loc_1);
                this.markDic[_loc_1] = getDisplayChildByName("mark_" + _loc_1);
                this.markDic[_loc_1].mouseEnabled = false;
                _loc_1++;
            }
            this.tips = getDisplayChildByName("tips");
            this.tipText = this.tips["des"];
            this.tipText.autoSize = TextFieldAutoSize.LEFT;
            this.tipText.multiline = false;
            this.tipText.wordWrap = false;
            this.tips.visible = false;
            return;
        }// end function

        private function addEvent() : void
        {
            FrameworkGlobal.addMsgListen(NewActivityEvent.NEW_ACT_RANK_INFO_UPDATE, this.rankInfoUpdate);
            return;
        }// end function

        public function updateByActInfo(param1:NewActivityInfo) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.iconDic)
            {
                return;
            }
            this.iconDic = new Dictionary();
            _loc_2 = 1;
            _loc_2 = 1;
            while (_loc_2 <= 3)
            {
                
                _loc_3 = new IconItem();
                _loc_3.setImageXY(6, 6);
                _loc_3.setImageSize(56, 56);
                _loc_3.setCountTxtXY(56 - 7, 56 - 18);
                _loc_3.setWH(66, 66);
                _loc_3.x = this.markDic[_loc_2].x;
                _loc_3.y = this.markDic[_loc_2].y;
                this.iconDic[_loc_2] = _loc_3;
                _loc_3.setInfo(param1.activityItemLists[(_loc_2 - 1)].jobAwardList[0]);
                addChild(_loc_3);
                _loc_2++;
            }
            _loc_2 = 1;
            while (_loc_2 <= 3)
            {
                
                addChild(this.markDic[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        public function rankInfoUpdate(event:NewActivityEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = event.data as ResGetRankInfoMessage;
            if (_loc_2)
            {
                _loc_3 = _loc_2.infoList.splice(-1, 1);
                if (_loc_2.infoList.length && _loc_2.infoList[0].playerId.equal(UserObj.getInstance().playerInfo.personId))
                {
                    this.nameDic[1].text = _loc_2.infoList[0].playerName;
                }
                else
                {
                    this.nameDic[1].text = LanguageCfgObj.getInstance().getByIndex("10155");
                }
                _loc_4 = 1;
                while (_loc_4 < 3)
                {
                    
                    if (_loc_2.infoList.length > _loc_4)
                    {
                        this.nameDic[(_loc_4 + 1)].text = _loc_2.infoList[_loc_4].playerName;
                    }
                    else
                    {
                        this.nameDic[(_loc_4 + 1)].text = LanguageCfgObj.getInstance().getByIndex("12108");
                    }
                    _loc_4++;
                }
                _loc_5 = -1;
                _loc_4 = 0;
                while (_loc_4 < 3)
                {
                    
                    if ((_loc_2.infoList.length - 1) >= _loc_4 && _loc_2.infoList[_loc_4].playerId.equal(UserObj.getInstance().playerInfo.personId))
                    {
                        _loc_5 = _loc_4 + 1;
                    }
                    _loc_4++;
                }
                if (_loc_5 != -1 && _loc_5 != 1)
                {
                    this.tips.y = 53 + (_loc_5 - 2) * (this.nameDic[2].y - this.nameDic[1].y);
                    this.tips.visible = true;
                    this.tipText.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12109"), [ToolKit.getMoneyString(uint(_loc_2.infoList[_loc_5 - 2].data))]);
                    this.tips.width = this.tipText.width + 30;
                }
                else
                {
                    this.tips.visible = false;
                }
            }
            return;
        }// end function

    }
}
