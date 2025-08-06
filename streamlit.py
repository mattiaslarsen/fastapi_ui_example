import streamlit as st
import requests
import pandas as pd
from typing import List, Dict, Any

# API-konfiguration - samma som frontend
API_BASE_URL = "http://localhost:8000"

def fetch_actors() -> List[Dict[str, Any]]:
    """Hämtar skådespelare från API - pure data fetching"""
    try:
        response = requests.get(f"{API_BASE_URL}/actors")
        response.raise_for_status()
        data = response.json()
        return data.get("data", [])
    except Exception as e:
        st.error(f"Kunde inte hämta data från API: {e}")
        return []

def fetch_stats() -> Dict[str, Any]:
    """Hämtar statistik från API - pure data fetching"""
    try:
        response = requests.get(f"{API_BASE_URL}/stats")
        response.raise_for_status()
        data = response.json()
        return data.get("data", {})
    except Exception as e:
        st.error(f"Kunde inte hämta statistik: {e}")
        return {}

def main():
    st.set_page_config(
        page_title="Actor Showcase - Streamlit",
        page_icon="🎬",
        layout="wide"
    )
    
    st.title("🎬 Actor Showcase - Streamlit")
    st.markdown("**Pure presentation från FastAPI backend**")
    
    # Sidebar med API-status
    with st.sidebar:
        st.header("🔗 API Status")
        try:
            response = requests.get(f"{API_BASE_URL}/api/status")
            if response.status_code == 200:
                st.success("✅ API tillgängligt")
                st.info(f"Backend: {API_BASE_URL}")
            else:
                st.error("❌ API inte tillgängligt")
        except:
            st.error("❌ API inte tillgängligt")
            st.info("Kör: make api-types")
    
    # Huvudinnehåll
    col1, col2 = st.columns([2, 1])
    
    with col1:
        st.header("📊 Skådespelare")
        
        # Hämta data från API
        actors = fetch_actors()
        
        if actors:
            # Konvertera till DataFrame för snygg visning
            df = pd.DataFrame(actors)
            
            # Formatera data för visning
            df_display = df.copy()
            df_display['Oscars'] = df_display['oscars'].apply(
                lambda x: f"🏆 {x}" if x > 0 else "0"
            )
            df_display['Land'] = df_display['country']
            df_display['Född'] = df_display['birth_year']
            
            # Visa tabell
            st.dataframe(
                df_display[['name', 'Land', 'Född', 'Oscars']],
                column_config={
                    "name": "Namn",
                    "Land": "Land",
                    "Född": "Födelseår",
                    "Oscars": "Oscar-priser"
                },
                hide_index=True,
                use_container_width=True
            )
            
            st.info(f"Visar {len(actors)} skådespelare från API")
        else:
            st.warning("Inga skådespelare hittades")
    
    with col2:
        st.header("📈 Statistik")
        
        # Hämta statistik från API
        stats = fetch_stats()
        
        if stats:
            # Visa statistik-kort
            col_a, col_b = st.columns(2)
            
            with col_a:
                st.metric("Totalt antal", stats.get("total_actors", 0))
                st.metric("Oscar-priser", stats.get("total_oscars", 0))
            
            with col_b:
                st.metric("Länder", stats.get("unique_countries", 0))
                st.metric("Snitt Oscar", f"{stats.get('average_oscars', 0):.1f}")
            
            # Visa länder
            if "countries" in stats:
                st.subheader("🌍 Länder")
                for country in stats["countries"]:
                    st.write(f"• {country}")
        else:
            st.warning("Kunde inte hämta statistik")
    
    # Footer med rörlighetsprinciper
    st.markdown("---")
    st.markdown("""
    **🏗️ Rörlighetsprinciper följda:**
    - ✅ Backend-logik förstärkning (API hanterar all logik)
    - ✅ Pure presentation (Streamlit visar bara data)
    - ✅ Loose coupling (API fungerar oberoende av UI)
    - ✅ Pydantic som typmaster (samma data som React-frontend)
    """)

if __name__ == "__main__":
    main() 