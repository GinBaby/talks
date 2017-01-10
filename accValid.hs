import Data.List (null, sort)
import Data.Validation

isAnagram :: String -> String -> Bool
isAnagram xs ys = sort xs == sort ys

maybeWord :: String -> Maybe String
maybeWord xs = 
    case null xs of
        True -> Nothing
        False -> do
            case (all isAlpha xs) of
                False -> Nothing
                True -> Just xs

display :: Maybe Bool -> IO ()
display maybeAna =
    case maybeAna of
        Nothing    -> putStrLn "This is not valid input."
        Just False -> putStrLn "These are not anagrams."
        Just True  -> putStrLn "These words are anagrams."


main :: IO ()
main = do
    putStrLn "Please enter a word."
    firstWord <- getLine
    putStrLn "Please enter a second word."
    secondWord <- getLine
    let maybeAna = do
            first  <- maybeWord firstWord
            second <- maybeWord secondWord
            return $ isAnagram first second
    display maybeAna








-- Intuitively, it can't be made a monad because in a monad, the effect 
-- (i.e. the validation failures) of a computation can depend on previously 
-- bound results. But in the case of a failure, there is no result. So Either 
-- has no choice than to short-circuit to failure in that case, since there is 
-- nothing to feed to the subsequent functions on right-hand sides of (>>=)s.

-- This is in stark contrast to applicative functors, where the effect (in this 
--     case, the validation failures) cannot depend on other results, which is 
-- why we can get all validation failures without having to feed results (where 
--     would they come from?) from one computation to the other.