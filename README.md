# CzechTwit
Politické tweety - cvičení na integraci Twitteru a textovou analýzu v R.

## Cíl snažení
- vyzkoušet práci s daty z Twitteru (R-ková package `twitteR`)  
- ukázat, co nám říká nejpopopulárněujší politik českého twitteru (@AndrejBabis s necelými 330 tisíci následovníky)
- ukázat, co se říká o nejpopulárnějším politikovi českého twitteru mezi ostatními uživateli

### O čem k nám mluví Andrej Babiš?
Takto vypadají nejčastější slova tweetů @AndrejBabis poslední doby, očištěná o slovní vatu:

<p align="center">
  <img src="https://github.com/jlacko/CzechTwit/blob/master/babis.png?raw=true" alt="WordCloud - Babiš o sobě"/>
</p>

Pan ministr mluví především o penězích (číslice zanedbávám, takže zbyly koruny a miliardy), částečně o České republice a sociální demokracii. Oceňuji, že se do první desítky nejpoužívanějších slov dostalo "fakt" ("jako" uzavírá druhou desítku, "sory" se mezi favority nedostalo).

### A o čem se baví *Vox Populi*? 
Takto vypadá výsledek hledání spojení *"Andrej+Babiš"* mezi všemi uživateli českého twitteru:

<p align="center">
  <img src="https://github.com/jlacko/CzechTwit/blob/master/o_babisovi.png?raw=true" alt="WordCloud - my o Babišovi"/>
</p>
Lid prostý když se baví o Andreji Babišovi tak se baví především o Andreji Babišovi. S dalekým odstupem za jménem pana ministra následuje slovo "ano", následované slovy "čapí" a "hnízdo". Druhou desítku uzavírají slova "policie" a "stíhání".  
   
### Poznámka pod čarou: 
Tweety jsou svojí povahou prchavé; tyto jsou staženy v pátek 11. 8. 2017 večer, v jiný den a jiný čas dodá API jiný výsledek.
