package com.game.bank.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.bank.cfg.*;
    import com.game.bank.control.*;
    import com.game.bank.events.*;
    import com.game.bank.model.*;
    import com.game.mall.control.*;
    import com.game.mall.model.*;
    import com.game.prompt.model.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class UpBankView extends Component
    {
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var txt4:TextField;
        private var img:MovieClip;
        private var _img:Image;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var dropList:MovieClip;
        private var dl:DropList;
        private var mc_List:MovieClip;
        private var list:List;
        private var url:String = "";
        public static var diamondArray:Array = [1000, 3000, 5000, 10000];
        public static var MONTH_DAYS:int = 31;

        public function UpBankView()
        {
            initComponentUI("upBankPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt1 = getDisplayChildByName("txt1");
            this.txt2 = getDisplayChildByName("txt2");
            this.txt3 = getDisplayChildByName("txt3");
            this.txt4 = getDisplayChildByName("txt4");
            this.txt1.selectable = false;
            this.txt1.mouseWheelEnabled = false;
            this.txt2.selectable = false;
            this.txt3.selectable = false;
            this.txt4.selectable = false;
            var _loc_1:* = PromptModel.getInstance().getItemFromMark("lfc_bank_001").system_message;
            var _loc_2:* = /<\/br>/g;
            _loc_1 = _loc_1.replace(_loc_2, "\n");
            this.txt1.htmlText = _loc_1;
            _loc_1 = PromptModel.getInstance().getItemFromMark("lfc_bank_003").system_message;
            _loc_1 = _loc_1.replace(_loc_2, "\n");
            _loc_2 = /\\n/g;
            _loc_1 = _loc_1.replace(_loc_2, "\n");
            this.txt2.htmlText = _loc_1;
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10386"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10387"));
            this.dropList = getDisplayChildByName("dropList") as MovieClip;
            this.mc_List = getDisplayChildByName("mc_List");
            this.list = new List(462, 178);
            this.mc_List.addChild(this.list);
            this.img = getDisplayChildByName("img");
            this._img = new Image();
            this._img.smoothing = true;
            this.img.addChild(this._img);
            this.dl = new DropList(this.dropList, 85, 125);
            this.dl.setScrollBarVisible(false);
            this.dl.addEvtListener(Event.CHANGE, this.update);
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            BankData.getInstance().addEvtListener(BankEvent.UP_BANK_CHANGE, this.update);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            switch(event.target)
            {
                case this.btn1:
                {
                    MallControl.getInstance().openMall(MallModel.BINDDIAMOND);
                    break;
                }
                case this.btn2:
                {
                    _loc_2 = 4 - this.dl.itemNum + this.dl.selectIndex;
                    if (_loc_2 >= 4)
                    {
                        _loc_2 = 3;
                    }
                    BankControl.getInstance().reqBuyBank((this.dl.selectIndex == -1 ? (3 - this.dl.itemNum) : (_loc_2)) + 1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function update(event:Event = null) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = false;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            this.list.reset();
            var _loc_2:* = BankData.getInstance().buyLv;
            if (event && event is BankEvent || !event)
            {
                switch(_loc_2)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }
            var _loc_3:* = BankData.getInstance().getUpSign;
            var _loc_4:* = BankRateCfgObj.getInstance().map;
            var _loc_5:* = [];
            for (_loc_6 in _loc_4)
            {
                
                _loc_5[_loc_6] = _loc_4[_loc_6];
            }
            _loc_7 = 0;
            _loc_8 = false;
            _loc_9 = 0;
            _loc_10 = 0;
            while (_loc_10 < _loc_5.length)
            {
                
                if (_loc_5[_loc_10])
                {
                    _loc_6 = _loc_5[_loc_10];
                    _loc_11 = new Object();
                    _loc_11.level = int(_loc_6.q_level);
                    if (diamondArray[(_loc_2 - 1)] * int(_loc_6.q_reward_rate) / 100 > _loc_3[_loc_6.q_level] && UserObj.getInstance().playerInfo.level >= int(_loc_6.q_level))
                    {
                        _loc_11.enabled = 1;
                    }
                    else
                    {
                        _loc_11.enabled = 0;
                    }
                    _loc_11.q_show_word = _loc_6.q_show_word;
                    _loc_11.q_word = _loc_6.q_word;
                    _loc_11.number = this.dl.selectIndex;
                    _loc_12 = new UpBankItem();
                    _loc_12.index = _loc_7;
                    _loc_12.obj = _loc_11;
                    this.list.add(_loc_12);
                    _loc_7++;
                    if (_loc_11.enabled == 1 && !_loc_8)
                    {
                        _loc_8 = true;
                        _loc_9 = _loc_7 - 1;
                    }
                }
                _loc_10++;
            }
            this.list.scrollToByContent(_loc_9 * _loc_12.height);
            if (_loc_2 > 0 && _loc_2 <= 4)
            {
                this.txt4.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11935"), [diamondArray[(_loc_2 - 1)]]);
            }
            else
            {
                this.txt4.text = LanguageCfgObj.getInstance().getByIndex("10389");
            }
            if (_loc_2 == 4 || UserObj.getInstance().playerInfo.level > 250)
            {
                this.btn2.filters = [FrameworkGlobal.colorMat];
                this.btn2.enabled = false;
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
