package com.game.bank.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.bank.control.*;
    import com.game.team.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MonthBankItem extends ListItemBase implements IItem
    {
        private var txt1:TextField;
        private var txt2:TextField;
        private var btn:BaseButton;
        private var _info:Object;

        public function MonthBankItem(param1:String = "backDiamondItem")
        {
            super(param1);
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txt1 = _content.getChildByName("txt1") as TextField;
            this.txt1.mouseEnabled = false;
            this.txt2 = _content.getChildByName("txt2") as TextField;
            this.txt2.mouseEnabled = false;
            this.btn = new BaseButton(_content.getChildByName("btn"));
            this.btn.addEvtListener(MouseEvent.CLICK, this.__click);
            mcBack = _content.getChildByName("mc") as MovieClip;
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txt1.textColor = param1;
            this.txt2.textColor = param1;
            return;
        }// end function

        override public function set index(param1:int) : void
        {
            _index = param1;
            setBackFrame(_index % 2 == 0 ? (1) : (2));
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
                if (mcBack)
                {
                    mcBack.gotoAndStop(3);
                }
            }
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        override protected function setSelect() : void
        {
            if (selected)
            {
                this.setTextColor(COLOR_SELECT);
                if (mcBack)
                {
                    mcBack.gotoAndStop(4);
                }
            }
            else
            {
                this.setTextColor(COLOR_NORMAL);
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._info = param1;
            this.setInfo(param1, true);
            return;
        }// end function

        public function refresh() : void
        {
            this.setInfo(this._info, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    switch(index)
                    {
                        case 0:
                        {
                            this.txt1.text = LanguageCfgObj.getInstance().getByIndex("10381");
                            this.txt2.text = "1000";
                            break;
                        }
                        case 1:
                        {
                            this.txt1.text = LanguageCfgObj.getInstance().getByIndex("10382");
                            this.txt2.text = "100";
                            break;
                        }
                        default:
                        {
                            this.txt1.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11930"), [index]);
                            this.txt2.text = "100";
                            break;
                        }
                    }
                    this.btn.setText(LanguageCfgObj.getInstance().getByIndex("10383"));
                    if (param1.state == 2)
                    {
                        this.btn.enabled = true;
                    }
                    else
                    {
                        this.btn.enabled = false;
                        switch(param1.state)
                        {
                            case 1:
                            {
                                (this.btn.getDisplay() as MovieClip).gotoAndStop(6);
                                break;
                            }
                            case 3:
                            {
                                (this.btn.getDisplay() as MovieClip).gotoAndStop(7);
                                break;
                            }
                            case 4:
                            {
                                (this.btn.getDisplay() as MovieClip).gotoAndStop(5);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            switch(event.currentTarget)
            {
                case this.btn:
                {
                    if (index == 0)
                    {
                        BankControl.getInstance().reqGetMonthBank(0);
                    }
                    else
                    {
                        BankControl.getInstance().reqGetMonthBank(1);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
