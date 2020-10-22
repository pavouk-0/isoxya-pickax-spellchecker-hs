module ISX.Plug.Spellchecker.ParserSpec (spec) where


import              ISX.Plug.Spellchecker.Parser
import              ISX.Test
import              Prelude                                 hiding  (get)


spec :: Spec
spec = do
    describe "example.com" $
        it "apex" $
            testPage "example.com/"
    
    describe "www.pavouk.tech" $ do
        it "apex" $
            testPage "www.pavouk.tech/"
        
        it "robots" $
            testPage "www.pavouk.tech/robots.txt"
        
        it "image" $
            testPage "www.pavouk.tech/wp-content/themes/pv-www-theme-2.1.1/assets/images/logo/pv-center.svg.inv.svg.png"
    
    describe "www.tiredpixel.com" $
        it "apex" $
            testPage "www.tiredpixel.com/"


testPage :: Text -> IO ()
testPage url = do
    procI <- fProcI url Nothing
    let texts = parse procI
    assertTextsLookup texts url