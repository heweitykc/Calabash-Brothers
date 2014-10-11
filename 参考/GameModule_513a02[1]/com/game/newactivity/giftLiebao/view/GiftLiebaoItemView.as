package com.game.newactivity.giftLiebao.view
{
    import com.f1.*;
    import com.game.newactivity.gift.locale.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.text.*;

    public class GiftLiebaoItemView extends BaseSprite
    {
        private var itemView:IconItem;
        private var viewTitle:TextField;
        public static var ICON_WIDTH:int = 48;
        public static var ICON_HEIGHT:int = 48;
        private static var ICON_NAME_SEP:int = 2;
        public static var HEIGHT:int = ICON_HEIGHT + ICON_NAME_SEP + 16;

        public function GiftLiebaoItemView()
        {
            this.itemView = new IconItem("backpackbox_bg");
            this.itemView.setImageXY(4, 4);
            this.itemView.setWH(ICON_WIDTH, ICON_HEIGHT);
            this.itemView.setCountTxtXY(ICON_WIDTH - 7, ICON_HEIGHT - 18);
            addChild(this.itemView);
            this.viewTitle = new TextField();
            this.viewTitle.defaultTextFormat = new TextFormat(GiftText.font, 12, 16578048);
            this.viewTitle.autoSize = TextFieldAutoSize.LEFT;
            this.viewTitle.y = ICON_HEIGHT + ICON_NAME_SEP;
            addChild(this.viewTitle);
            return;
        }// end function

        public function setData(param1:PropInfo) : void
        {
            this.itemView.setInfo(param1);
            this.viewTitle.text = param1.q_name;
            this.viewTitle.x = (ICON_WIDTH - this.viewTitle.width) / 2;
            return;
        }// end function

    }
}
