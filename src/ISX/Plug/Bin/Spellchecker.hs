{-# LANGUAGE TemplateHaskell #-}


module Main (main) where


import           Control.Concurrent          (forkIO)
import           Control.Lens                (makeLenses)
import           Data.Version                (showVersion)
import           ISX.Plug.Spellchecker
import           Paths_isx_plug_spellchecker (version)
import           Snap.Snaplet
import           System.IO
import qualified TPX.Com.Snap.Main           as S


newtype App = App {
    _spellchecker :: Snaplet Spellchecker}

makeLenses ''App

main :: IO ()
main = do
    let ver = toText $ showVersion version
    hPutStrLn stderr $ "Isoxya plugin: Spellchecker " <> toString ver
    done <- S.init
    tId <- forkIO $ serveSnaplet S.config initApp
    S.wait done tId


initApp :: SnapletInit App App
initApp = makeSnaplet "App" "" Nothing $ do
    spellchecker' <- nestSnaplet "" spellchecker initSpellchecker
    return $ App spellchecker'
