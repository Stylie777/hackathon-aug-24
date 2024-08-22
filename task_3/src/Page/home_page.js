"use client"
import { useState } from 'react';
import axios from "axios";


const HomePage = () => {
    const [invest_amount, setinvest_amount] = useState(null)
    const [bought_date, setbought_date] = useState(new Date());
    const [bought_price, setbought_price] = useState(null)
    const [todayClose, setTodayClose] = useState(null)
    const [no_shares, setShare]= useState(null);
    const [ValueNow, setValueNow] = useState(null);
    const [p_l_percent, setPLpercent] = useState(null)

    const Calulate = async () => {
        try {       
            const today = new Date().toISOString().split('T')[0];
            let new_bought_date = new Date(bought_date)
            new_bought_date = new_bought_date.toISOString().split('T')[0]
            
            const today_stock = await axios.get('http://api.marketstack.com/v1/eod', {
                params: {
                access_key: '9450f28bb21a4a62db630269e60d468b', 
                symbols: 'ARM',
                date_form: today,
                date_to:today,
                }
            });

            const bought_date_stock = await axios.get('http://api.marketstack.com/v1/eod', {
                params: {
                access_key: '9450f28bb21a4a62db630269e60d468b', 
                symbols: 'ARM',
                date_form: new_bought_date,
                date_to:new_bought_date,
                }
            });

            const todayData = today_stock.data.data[0] || {}
            const boughtData = bought_date_stock.data.data[0] || {}
            setTodayClose(todayData.close)
            setbought_price(boughtData.close)
            setShare((invest_amount/bought_price).toFixed(2))
            setValueNow(((no_shares * todayClose)-invest_amount).toFixed(2))
            setPLpercent((ValueNow*100/invest_amount).toFixed(2))

        } catch (error) {
            console.error('Error fetching stock data:',error);
        }
        
    }

  return (
    <div className="App">
      <h2 className="my-4 font-bold text-2xl text-left p-4 text-cyan-600">
        Stock Calculator 
      </h2>
    <div className=' bg-slate-200 rounded p-4 mx-2'>
        <form>
            <div className="flex text-left space-x-4 py-2">
                <div className="w-1/2 font-bold my-2 text-sm text-cyan-600">
                    <label htmlFor="invest_amount">Amount spent on the stock ($)</label>
                    <input
                    id='invest_amount'
                    type='text'
                    value={invest_amount}
                    onChange={e => setinvest_amount(e.target.value)}
                    className = 'rounded p-2 my-2 w-full border'
                    />
                </div>
                <div className="w-1/2 font-bold my-2 text-sm text-cyan-600">
                    <label htmlFor="invest_date">Date bought</label>
                        <input
                        id='invest_date'
                        type='date'
                        value={bought_date}
                        onChange={e => setbought_date(e.target.value)}
                        className =' text-slate-500 rounded my-2 p-2 w-full border'
                        />
                </div>
            </div>
    
        </form>
        <button onClick={Calulate} className='bg-cyan-600 w-full text-white py-1 mx-4 ml-auto rounded block font-semibold text-base'>
            Update
        </button>
      </div>
    
        <div className='pt-4'>
            <div className=' bg-blue-50 rounded p-2 mx-2'>
                <h2 className=' font-bold my-2 text-lg text-left text-blue-800'>
                            Stock Data for ARM
                </h2>
                <div className='flex space-x-4'>
                    <p className='w-1/2 py-2 font-semibold my-2 text-base text-left text-blue-700'> You bought ARM in: {JSON.stringify(bought_price )}</p>
                    <p className='w-1/2 py-2 font-semibold my-2 text-base text-left text-blue-700'> This is today's price: {JSON.stringify(todayClose)}</p>
                </div>
                <div className='flex space-x-4'>
                    <p className='w-1/2 py-2 font-semibold my-2 text-base text-left text-blue-700'> You own {no_shares} shares </p>
                    <p className='w-1/2 py-2 font-semibold my-2 text-base text-left text-blue-700'> Total P&L: ${ValueNow} ({p_l_percent})% </p>
                </div>
            </div>
        </div>
    </div>
  );
}

export default HomePage;
